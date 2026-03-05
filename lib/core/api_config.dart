/// API base URL and endpoints for ZEN CARE backend.
class ApiConfig {
  static const String baseUrl = 'https://zencareservice.com/servicy/api';
  /// Base URL for relative file paths (e.g. profile photo)
  static const String baseUrlForFiles = 'https://zencareservice.com/servicy';
  static String get orderHistory => '$baseUrl/order_history.php';

  static String get register => '$baseUrl/register.php';
  static String get login => '$baseUrl/login.php';
  static String get cart => '$baseUrl/cart.php';
  static String get logout => '$baseUrl/logout.php';
  static String get checkSession => '$baseUrl/check_session.php';
  static String get fetchUser => '$baseUrl/fetch_user.php';
  static String get updateProfile => '$baseUrl/update_profile.php';
  static String get serviceableAreas => '$baseUrl/fetch_serviceable_areas.php';
  static String get partnerRegister => '$baseUrl/partner_register.php';
  static String get payments => '$baseUrl/payments.php';
  static String get paymentConfirmation => '$baseUrl/paymentConfirmation.php';
  static String get paymentVerify => '$baseUrl/payment_verify.php';
  static String get bookAppointment => '$baseUrl/book_appointment.php';
}
