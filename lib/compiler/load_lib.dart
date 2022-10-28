import 'dart:io';

class LibLoader {
  String load(String lib) {
    String filePath = "../OCamLisp/libraries/$lib.ml";
    if (File(filePath).existsSync()) {
      return "${File(filePath).readAsStringSync()}\n\n";
    } else {
      throw("Could not locate library `$lib` at `$filePath`.");
    }
  }
}