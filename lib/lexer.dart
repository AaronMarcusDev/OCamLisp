import 'package:ocamlisp/share.dart';

class Lexer {
  List<Token> _lex(int line, String program) {
    List<Token> lexemes = [];
    for (String lexeme
        in program.replaceAll("(", " ( ").replaceAll(")", " ) ").split(" ")) {
      if (lexeme.trim().isNotEmpty) {
        try {
          lexemes.add(Token(line, TokenType.INTEGER, int.parse(lexeme)));
        } catch (e) {
          try {
            lexemes.add(Token(line, TokenType.FLOAT, double.parse(lexeme)));
          } catch (e) {
            lexemes.add(Token(line, TokenType.KEYWORD, lexeme));
          }
        }
      }
    }
    return lexemes;
  }

  List<Token> lexProgram(String program) {
    List<Token> tokens = [];
    int line = 0;
    for (String lineContent in program.split("\n")) {
      line += 1;
      for (Token token in _lex(line, lineContent)) {
        tokens.add(token);
      }
    }
    return tokens;
  }
}
