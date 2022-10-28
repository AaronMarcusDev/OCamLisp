import 'dart:io';

class LibLoader {
  String load(String lib) {
    String filePath = "../OCamLisp/libraries/$lib";
    if (File(filePath).existsSync()) {
      return File(filePath).readAsStringSync();
    } else {
      throw("Could not locate library `$lib` at `$filePath`.");
    }
  }
}