import 'package:flutter/material.dart';

import 'package:zencare/services/auth_service.dart';

/// Google Play review access: reviewers will not use SMS OTP or self-register.
///
/// Your normal flow is: **register** (OTP) → later **login** (mobile + password → SMS OTP → token).
/// For Play, create **one backend test user** and share only **mobile + password** in Play Console
/// (App access). Reviewers must **not** use Register — they sign in with that test account only.
///
/// **Enable only for Play release builds** by passing `--dart-define` values when
/// building the AAB/APK. Leave all unset for normal development; behavior is unchanged.
///
/// **playstore-android branch (recommended workflow)**  
/// Same app code as branch `android`; Play-only builds add defines via JSON:
/// - Copy `playstore_dart_defines.json.example` to `playstore_dart_defines.json` (gitignored).
/// - Fill values, run `tool/build_playstore_appbundle.ps1`, or:
///   `flutter build appbundle --release --dart-define-from-file=playstore_dart_defines.json`
///
/// **1) Recommended — skip OTP after login (needs a long-lived token from your backend)**  
/// Log in once as the test user on a dev build, copy `token`, `user id`, and name from
/// the login API response, then build release with:
///
/// ```
/// flutter build appbundle --release \
///   --dart-define=PLAY_REVIEW_PHONE=9876543210 \
///   --dart-define=PLAY_REVIEW_PASSWORD=YourReviewPassword \
///   --dart-define=PLAY_REVIEW_TOKEN=paste_jwt_or_session_token \
///   --dart-define=PLAY_REVIEW_USER_ID=123 \
///   --dart-define=PLAY_REVIEW_USER_NAME="Review User"
/// ```
///
/// Put the **same** phone and password in Play Console → App content → App access
/// (instructions for reviewers). Refresh the token before each submission if it expires.
///
/// **2) Optional — static OTP step** (if reviewers still reach the OTP screen, e.g. they
/// use phone+password that hit the real API first): also set a 6-digit value:
/// `--dart-define=PLAY_REVIEW_OTP=123456` and ensure [confirmLoginOtp] fallback runs
/// after the server rejects OTP, or prefer fixing [login.php] to accept that OTP for the
/// review number only (no token in the app).
///
/// **Security:** The review token and password exist inside the shipped binary. Use a
/// dedicated low-privilege test account; rotate credentials after review if needed.
class PlayReviewConfig {
  static const String reviewerPhone = String.fromEnvironment('PLAY_REVIEW_PHONE', defaultValue: '');
  static const String reviewerPassword = String.fromEnvironment('PLAY_REVIEW_PASSWORD', defaultValue: '');
  static const String reviewerToken = String.fromEnvironment('PLAY_REVIEW_TOKEN', defaultValue: '');
  static const String reviewerUserId = String.fromEnvironment('PLAY_REVIEW_USER_ID', defaultValue: '');
  static const String reviewerUserName = String.fromEnvironment('PLAY_REVIEW_USER_NAME', defaultValue: '');
  static const String reviewerOtp = String.fromEnvironment('PLAY_REVIEW_OTP', defaultValue: '');

  static String _digitsOnly(String s) => s.replaceAll(RegExp(r'\D'), '');

  /// True when phone/password login can skip the network and OTP using [reviewerToken].
  static bool get isLoginBypassEnabled =>
      reviewerPhone.isNotEmpty &&
      reviewerPassword.isNotEmpty &&
      reviewerToken.isNotEmpty &&
      reviewerUserId.isNotEmpty;

  static bool matchesReviewerCredentials(String phone, String password) {
    if (!isLoginBypassEnabled) return false;
    return _digitsOnly(phone) == _digitsOnly(reviewerPhone) && password == reviewerPassword;
  }

  /// OTP-screen fallback: same token session when OTP matches compiled [reviewerOtp].
  static bool matchesReviewerOtp(String phone, String otp) {
    if (!isLoginBypassEnabled || reviewerOtp.length != 6) return false;
    return _digitsOnly(phone) == _digitsOnly(reviewerPhone) && otp.trim() == reviewerOtp;
  }

  static Future<void> completeReviewSessionAndGoHome(BuildContext context) async {
    final name = reviewerUserName.trim().isEmpty ? 'Play Store reviewer' : reviewerUserName.trim();
    await AuthService.saveLogin(
      token: reviewerToken.trim(),
      userId: reviewerUserId.trim(),
      userName: name,
    );
    if (!context.mounted) return;
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
