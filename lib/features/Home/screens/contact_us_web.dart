// Web-specific implementation
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui;

void registerIframeView(String url) {
  final viewType = 'iframe-${url.hashCode}';

  // Register view factory for web
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    viewType,
        (int viewId) {
      final iframe = html.IFrameElement()
        ..src = url
        ..style.border = "none"
        ..style.width = "100%"
        ..style.height = "100%";
      return iframe;
    },
  );
}