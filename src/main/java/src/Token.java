package src;

public class Token {
    public int type;
    public String lexeme;
    public int line;
    public int column;

    public Token(int type, String lexeme, int line, int column) {
        this.type = type;
        this.lexeme = lexeme;
        this.line = line;
        this.column = column;
    }

    @Override
    public String toString() {
        return "Token{" + "type=" + type + ", lexeme='" + lexeme + '\'' + ", line=" + line + ", column=" + column + '}';
    }
}
