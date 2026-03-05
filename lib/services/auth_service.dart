import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/core/api_config.dart';

/// Handles auth token storage, session validation, and full user profile.
///
/// **Token flow (matches API):**
/// - After login: store `response['token']` (trimmed). Same token is used for all auth calls.
/// - check_session.php (GET): use query only — `check_session.php?token=YOUR_TOKEN` (Option A).
///   Server reads query first; works when browsers/servers strip Authorization.
/// - POST endpoints (logout, cart, profile): send token in headers (Authorization, X-Auth-Token).
///
/// 401 from check_session: "No token sent" → client must send ?token=...; "Session expired or invalid" → re-login.
class AuthService {
  static const _keyToken = 'auth_token';
  static const _keyUserId = 'userId';
  static const _keyUserName = 'userName';
  static const _keyUserProfile = 'user_profile';

  /// Headers for POST/PATCH. API accepts Authorization: Bearer, X-Auth-Token.
  static Map<String, String> tokenHeaders(String? token) {
    if (token == null || token.isEmpty) return {};
    return {
      'Authorization': 'Bearer $token',
      'X-Auth-Token': token,
    };
  }

  /// Query params for GET. Use for check_session, fetch_user, order_history so server always sees token.
  static Map<String, String> tokenQuery(String? token) {
    if (token == null || token.isEmpty) return {};
    return {'token': token};
  }

  /// Store login result. Token must be the exact string from login response (trimmed). Used for check_session.php?token=...
  static Future<void> saveLogin({
    required String token,
    required String userId,
    required String userName,
    Map<String, dynamic>? userProfile,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmedToken = token.trim();
    await prefs.setString(_keyToken, trimmedToken);
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserName, userName);
    if (userProfile != null) {
      await prefs.setString(_keyUserProfile, json.encode(userProfile));
    }
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  /// Returns the cached full user profile (from login or last checkSession/fetchUser).
  /// Fields: id, first_name, last_name, email, phone, address, photo, status.
  static Future<Map<String, dynamic>?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyUserProfile);
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = json.decode(raw);
      return map is Map<String, dynamic> ? map : null;
    } catch (_) {
      return null;
    }
  }

  /// Updates the cached profile (e.g. after profile update API).
  static Future<void> setProfile(Map<String, dynamic>? userProfile) async {
    final prefs = await SharedPreferences.getInstance();
    if (userProfile == null) {
      await prefs.remove(_keyUserProfile);
      return;
    }
    await prefs.setString(_keyUserProfile, json.encode(userProfile));
    final first = userProfile['first_name']?.toString() ?? '';
    final last = userProfile['last_name']?.toString() ?? '';
    final name = '$first $last'.trim();
    if (name.isNotEmpty) await prefs.setString(_keyUserName, name);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  /// Validates session with check_session.php. Option A (GET with query): token in URL so server always receives it.
  /// Returns session map (user_id, userName, user) if valid; null if no token, 401, or error.
  static Future<Map<String, dynamic>?> checkSession() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return null;
    try {
      // GET https://.../check_session.php?token=YOUR_TOKEN (token from login response)
      final uri = Uri.parse(ApiConfig.checkSession).replace(queryParameters: {'token': token});
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>?;
        if (data == null) return null;
        final ok = (data['statusCode'] == 200 || data['statusCode'] == '200') && data['logged_in'] == true;
        if (!ok) return null;
        final user = data['user'];
        if (user is Map<String, dynamic>) {
          await setProfile(user);
        }
        String? name;
        if (user is Map) {
          final first = user['first_name']?.toString() ?? '';
          final last = user['last_name']?.toString() ?? '';
          name = '$first $last'.trim();
          if (name.isEmpty) name = user['name']?.toString();
        } else {
          name = user?.toString();
        }
        return {
          'user_id': data['user_id']?.toString(),
          'userName': name ?? data['userName']?.toString() ?? await getUserName() ?? 'Guest',
          'user': user is Map<String, dynamic> ? user : null,
        };
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Fetches full profile from fetch_user.php. Sends token in query for reliable GET in browser.
  static Future<Map<String, dynamic>?> fetchUser() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return null;
    try {
      final uri = Uri.parse(ApiConfig.fetchUser).replace(queryParameters: {'token': token});
      final response = await http.get(uri);
      if (response.statusCode != 200) return null;
      final data = json.decode(response.body) as Map<String, dynamic>?;
      if (data == null) return null;
      final status = data['status']?.toString();
      if (status != 'success') return null;
      final user = data['data'];
      if (user is Map<String, dynamic>) {
        await setProfile(user);
        return user;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Call backend logout (clears server session and cart), then clear local prefs.
  static Future<void> logout() async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      try {
        final headers = <String, String>{'Content-Type': 'application/json'};
        headers.addAll(tokenHeaders(token));
        await http.post(Uri.parse(ApiConfig.logout), headers: headers);
      } catch (_) {}
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserProfile);
    await prefs.setBool('isLoggedIn', false);
  }

  /// Headers for authenticated requests (cart, payments, profile update, etc.). Includes Authorization and X-Auth-Token.
  static Future<Map<String, String>> authHeaders() async {
    final token = await getToken();
    final headers = <String, String>{'Content-Type': 'application/json'};
    headers.addAll(tokenHeaders(token));
    return headers;
  }
}
