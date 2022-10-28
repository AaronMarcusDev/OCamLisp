import 'package:ocamlisp/shared/common__share.dart';

class Parser {
  List<Token> parse(List<Token> tokens) {
    List<Token> tree = [];
    int errors = 0;

    void error(int line, String msg) {
      print("ERROR, line $line: $msg");
      errors++;
    }

    for (int c = 0; c < tokens.length; c++) {
      if (tokens[c].value == "true" || tokens[c].value == "false") {
        tree.add(Token(
            tokens[c].line, TokenType.BOOLEAN, (tokens[c].value == "true")));
      } else if (tokens[c].value == "(") {
        int line = tokens[c].line;
        List<Token> L = [];
        int nest = 0;
        try {
          for (;;) {
            c++;
            if (tokens[c].value == "(") {
              nest++;
            } else if (tokens[c].value == ")") {
              if (nest == 0) {
                L.add(tokens[c]);
                break;
              } else {
                nest -= 1;
              }
            }
            L.add(tokens[c]);
          }
          L.removeLast();
          tree.add(Token(line, TokenType.OBJECT, parse(L)));
        } catch (e) {
          error(line, "Unterminated Object.");
        }
      } else if (tokens[c].value == ")") {
        error(tokens[c].line, "Unexpected ')'.");
      } else {
        tree.add(tokens[c]);
      }
    }
    if (errors > 0) {
      exit(1);
    }
    return tree;
  }
}
