// ignore_for_file: constant_identifier_names

enum TokenType { INTEGER, FLOAT, BOOLEAN, KEYWORD, OBJECT, STRING }

class Token {
  int line;
  TokenType type;
  dynamic value;
  Token(this.line, this.type, this.value);
}
