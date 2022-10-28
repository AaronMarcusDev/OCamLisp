import 'package:ocamlisp/shared/common__share.dart';

class Generator {
  List<String> generate(List<Token> AST) {
    List<String> code = [];

    void error(int line, String msg) {
      print("ERROR, line $line: $msg");
      exit(1);
    }

    isObject(token) => token.type == TokenType.OBJECT;
    // ignore: non_constant_identifier_names
    ObjectSolver(token) => generate([token])[0];

    for (int c = 0; c < AST.length; c++) {
      Token token = AST[c];
      int line = AST[c].line;
      TokenType type = AST[c].type;
      dynamic value = AST[c].value;
      // print("$token $type $value");

      if (type == TokenType.OBJECT) {
        dynamic command = value[0].value;
        List<Token> args = value;
        args.removeAt(0);

        if (command == 'puts') {
          if (args.length > 1) {
            error(token.line, "Too many arguments for `puts`.");
          }
          if (isObject(args[0])) {
            try {
              code.add("print_endline \"${ObjectSolver(args[0])}\";;");
            } catch (e) {
              print("GENERATOR FAILED `PUTS` IN LINE: $line.");
            }
          } else {
            code.add("print_endline \"${args[0].value}\";;");
          }
        }
      } else {
        error(AST[c].line, "Expected an Object.");
      }
    }
    return code;
  }
}
