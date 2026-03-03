import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/core/api_config.dart';

/// Handles auth token storage and session validation.
/// Backend returns `token` on login/register; we store it and send as Bearer.
class AuthService {
  static const _keyToken = 'auth_token';
  static const _keyUserId = 'userId';
  static const _keyUserName = 'userName';

  static Future<void> saveLogin({
    required String token,
    required String userId,
    required String userName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserName, userName);
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

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  /// Validates token with backend; returns user map if valid, null otherwise.
  static Future<Map<String, dynamic>?> checkSession() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return null;
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.checkSession),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final ok = (data['statusCode'] == 200 || data['statusCode'] == '200') && data['logged_in'] == true;
        if (ok) {
          final user = data['user'];
          final name = user is Map ? user['name']?.toString() : (user?.toString());
          return {
            'user_id': data['user_id']?.toString(),
            'userName': name ?? data['userName']?.toString() ?? await getUserName() ?? 'Guest',
          };
        }
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
        await http.post(
          Uri.parse(ApiConfig.logout),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      } catch (_) {}
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
    await prefs.setBool('isLoggedIn', false);
  }

  /// Headers for authenticated requests (cart, payments, etc.).
  static Future<Map<String, String>> authHeaders() async {
    final token = await getToken();
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
