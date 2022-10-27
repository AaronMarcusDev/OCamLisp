import 'package:ocamlisp/lexer.dart';
import 'package:ocamlisp/parser.dart';
import 'package:ocamlisp/generator.dart';
import 'package:ocamlisp/share.dart';

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
  File("./main.ml").writeAsStringSync(code.join("\n"));
}
