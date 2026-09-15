import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AssetHelper {
  static final String _platformFolder = _resolvePlatformFolder();

  static String _resolvePlatformFolder() {
    if (kIsWeb) return 'desktop';
    if (Platform.isAndroid || Platform.isIOS) return 'phone';
    return 'desktop';
  }

  // Ảnh nền — CÓ bản riêng theo platform: assets/images/<platform>/<file>
  static String background(String fileName) =>
      'assets/images/$_platformFolder/$fileName';

  // Ảnh món ăn / mọi ảnh dùng chung — KHÔNG theo platform: assets/images/<file>
  static String image(String fileName) => 'assets/images/$fileName';
}