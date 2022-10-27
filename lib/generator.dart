import 'package:ocamlisp/share.dart';

class Generator {
  List<String> generate(List<Token> AST) {
    List<String> code = [];

    void error(int line, String msg) {
      print("ERROR, line $line: $msg");
      exit(1);
    }

    isObject(token) => token.type == TokenType.OBJECT;
    ObjectSolver(token) => generate([token])[0];

    for (int c = 0; c < AST.length; c++) {
      Token token = AST[c];
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
          if (args[0].type == TokenType.OBJECT) {
            code.add("print_endline(\"${ObjectSolver(args[0])}\");");
          } else {
            code.add("print_endline(\"${args[0].value}\");");
          }
        } else if (command == "+") {
          try {
            String OCamlSum = "0";
            num sum = 0;
            for (Token arg in args) {
              if (isObject(arg)) {
                sum += num.parse(ObjectSolver(arg));
                OCamlSum += "+";
                OCamlSum += ObjectSolver(arg);
              } else {
                sum += arg.value;
                OCamlSum += arg.value.toString();
              }
            }
            // code.add(sum.toString());
            code.add(OCamlSum);
          } catch (e) {
            error(token.line, "Invalid argument type for `+`.");
          }
        } else if (command == "-") {
          try {
            num sum = args[0].value;
            args.removeAt(0);
            for (Token arg in args) {
              if (isObject(arg)) {
                sum -= num.parse(ObjectSolver(arg));
              } else {
                sum -= arg.value;
              }
            }
            code.add(sum.toString());
          } catch (e) {
            error(token.line, "Invalid argument type for `+`.");
          }
        }
      } else {
        error(AST[c].line, "Expexted an Object.");
      }
    }
    return code;
  }
}
