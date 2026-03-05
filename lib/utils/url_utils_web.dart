import 'dart:html' as html;

/// Removes ?payment=...&txn=... from the browser URL so refresh doesn't re-trigger.
void clearPaymentParamsFromUrl() {
  final path = html.window.location.pathname ?? '';
  final cleanPath = path.isEmpty ? '/' : path;
  html.window.history.replaceState(null, '', cleanPath);
}
