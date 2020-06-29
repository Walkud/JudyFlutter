import 'dart:io';

import 'app_context.dart';

class MLog {
  static void log(Object object) {
    if (!AppContext.isRelease) {
      print(object);
    }
  }
}
