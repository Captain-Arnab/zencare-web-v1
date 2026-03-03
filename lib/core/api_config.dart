/// API base URL and endpoints for ZEN CARE backend.
class ApiConfig {
  static const String baseUrl = 'https://zencareservice.com/servicy/api';

  static String get register => '$baseUrl/register.php';
  static String get login => '$baseUrl/login.php';
  static String get cart => '$baseUrl/cart.php';
  static String get logout => '$baseUrl/logout.php';
  static String get checkSession => '$baseUrl/check_session.php';
  static String get serviceableAreas => '$baseUrl/serviceable_areas.php';
  static String get partnerRegister => '$baseUrl/partner_register.php';
  static String get payments => '$baseUrl/payments.php';
  static String get paymentConfirmation => '$baseUrl/paymentConfirmation.php';
  static String get bookAppointment => '$baseUrl/book_appointment.php';
}
