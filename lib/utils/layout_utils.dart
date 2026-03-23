import 'package:flutter/foundation.dart';

/// True when running on Android — use for forcing mobile-style layout.
bool get isAndroidLayout => defaultTargetPlatform == TargetPlatform.android;
