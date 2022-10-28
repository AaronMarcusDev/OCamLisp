import 'package:ocamlisp/shared/common__share.dart';
import 'package:ocamlisp/compiler/load_lib.dart';

LibLoader libLoader = LibLoader();

class Generator {
  List<String> code = [];

  void _addLib(String lib) {
    for (String line in lib.split("\n")) {
      code.add(line);
    }
  }

  void _init() {
    // Add libraries
    _addLib(libLoader.load("std"));
    code.add("(*user - program*)");
  }

  List<String> generate(List<Token> AST) {
    // Nested generator functions
    void error(int line, String msg) {
      print("ERROR, line $line: $msg");
      exit(1);
    }

    generateObj(x) => generate(x);

    // Load libraries
    _init();

    isObject(token) => token.type == TokenType.OBJECT;
    // ignore: non_constant_identifier_names
    ObjectSolver(token) => generateObj([token])[0];

    for (int c = 0; c < AST.length; c++) {
      Token token = AST[c];
      int line = AST[c].line;
      TokenType type = AST[c].type;
      dynamic value = AST[c].value;

      if (type == TokenType.OBJECT) {
        dynamic command = value[0].value;
        List<Token> args = value;
        args.removeAt(0);

        if (command == 'puts_int') {
          if (args.length > 1) {
            error(token.line, "Too many arguments for `puts`.");
          }
          if (isObject(args[0])) {
            try {
              code.add("puts_int (${ObjectSolver(args[0])});;");
            } catch (e) {
              print("GENERATOR FAILED `PUTS` IN LINE: $line.");
            }
          } else {
            code.add("puts_int ${args[0].value};;");
          }
        }
      } else {
        error(AST[c].line, "Expected an Object.");
      }
    }
    return code;
  }
}
