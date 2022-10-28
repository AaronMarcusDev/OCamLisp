import 'package:ocamlisp/lexer/lexer.dart';
import 'package:ocamlisp/parser/parser.dart';
import 'package:ocamlisp/compiler/generator.dart';
import 'package:ocamlisp/shared/common__share.dart';

Lexer lexer = Lexer();
Parser parser = Parser();
Generator generator = Generator();

String _loadFile(String file) {
  try {
    return File(file).readAsStringSync();
  } catch (e) {
    print("Error: File `$file` not found in current directory.");
    exit(1);
  }
}

void run(String file) {
  List<String> code =
      generator.generate(parser.parse(lexer.lexProgram(_loadFile(file))));
      print(code);
  File("./main.ml").writeAsStringSync(code.join("\n"));
}
