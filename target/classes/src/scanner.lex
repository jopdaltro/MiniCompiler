package src;
import java_cup.runtime.Symbol;

%%

%{
    private Token token;
    private int blockCommentLevel = 0; 
%}

%class Scanner
%cup
%type Symbol
%column
%line
%eofval{ 
	return new Symbol(sym.EOF,new String("fim do arrquivo"));
%eofval}
%state BLOCK_COMMENT 

// Defining regular expressions for tokens
WHITESPACE = [\n|\t|\r|\s]+
DIGIT = [0-9]
LETTER = [a-zA-Z]
ID = {LETTER}({LETTER}|{DIGIT}|_)*
VARSYM = [a-zA-Z_][a-zA-Z0-9_$%]*
INTEGER = 0|[1-9]{DIGIT}*
FLOAT = {DIGIT}+("."{DIGIT}+)?
STRING = \"([^\"\\]|\\.)*\" // Strings enclosed in double quotes
CHAR = \'([^\'\\]|\\.)\' // Characters enclosed in single quotes
TRUE = "true"
BOOL = "bool"
FALSE = "false"
ARRAY = \[({INTEGER}|{FLOAT}|{BOOL}|{CHAR}|{STRING})(,\s*({INTEGER}|{FLOAT}|{BOOL}|{CHAR}|{STRING}))*\]
TUPLE = \(\s*({INTEGER}|{FLOAT}|{BOOL}|{CHAR}|{STRING})(\s*,\s*({INTEGER}|{FLOAT}|{BOOL}|{CHAR}|{STRING}))*\s*\)

// Operators
ADD = "+"
SUBTRACT = "-"
MULTIPLY = "*"
DIVIDE = "/"
MODULO = "%"
EQUAL = "=="
LESS = "<"
LESS_EQUAL = "<="
GREATER = ">"
GREATER_EQUAL = ">="
EQUALEQUAL = "=="
EQUAL = "="
DIF = "!="
POT = "**"
AND = "&&"
OR = "||"
NOT = "!"
BAR = "|"
DOTDOT = ".."

// Delimiters
LPAREN = "\("
RPAREN = "\)"
LBRACKET = "\["
RBRACKET = "\]"
LBRACE = "\{"
RBRACE = "\}"
COMMA = ","
SEMICOLON = ";"
COLON = ":"
CRASIS = "`"
UNDER_LINE = "_"
LEFT_ARROW = "<-"

// Reserved keywords
IF = "if"
ELSE = "else"
CASE = "case"
IN = "in"
LET = "let"
OF = "of"
THEN = "then"
WHERE = "where"

// Comments
LINE_COMMENT = "--"[^(\n|\r)]*
DELIM_OPEN = "\\{-"
DELIM_CLOSE = "-\\}"
ANY = "[^\\}^-]+"

%%

{IF}              { return new Symbol(sym.IF, yytext()); }
{ELSE}            { return new Symbol(sym.ELSE, yytext()); }
{CASE}            { return new Symbol(sym.CASE, yytext()); }
{IN}              { return new Symbol(sym.IN, yytext()); }
{LET}             { return new Symbol(sym.LET, yytext()); }
{OF}              { return new Symbol(sym.OF, yytext()); }
{THEN}            { return new Symbol(sym.THEN, yytext()); }
{WHERE}           { return new Symbol(sym.WHERE, yytext()); }
{TRUE}            { return new Symbol(sym.TRUE, yytext()); }
{UNDER_LINE}      { return new Symbol(sym.UNDER_LINE, yytext()); }

{BOOL}            { return new Symbol(sym.BOOL, yytext()); }
{FALSE}           { return new Symbol(sym.FALSE, yytext()); }

{ID}              { return new Symbol(sym.ID, yytext()); }
{VARSYM}          { return new Symbol(sym.VARSYM, yytext()); }
{INTEGER}         { return new Symbol(sym.INTEGER, yytext()); }
{FLOAT}           { return new Symbol(sym.FLOAT, yytext()); }
{STRING}          { return new Symbol(sym.STRING, yytext()); }
{CHAR}            { return new Symbol(sym.CHAR, yytext()); }


// Estruturas
{ARRAY}           { return new Symbol(sym.ARRAY, yytext()); }
{TUPLE}           { return new Symbol(sym.TUPLE, yytext()); }

// Operadores
{ADD}             { return new Symbol(sym.ADD, yytext()); }
{SUBTRACT}        { return new Symbol(sym.SUBTRACT, yytext()); }
{MULTIPLY}        { return new Symbol(sym.MULTIPLY, yytext()); }
{DIVIDE}          { return new Symbol(sym.DIVIDE, yytext()); }
{MODULO}          { return new Symbol(sym.MODULO, yytext()); }
{EQUAL}           { return new Symbol(sym.EQUAL, yytext()); }
{LESS}            { return new Symbol(sym.LESS, yytext()); }
{LESS_EQUAL}      { return new Symbol(sym.LESS_EQUAL, yytext()); }
{GREATER}         { return new Symbol(sym.GREATER, yytext()); }
{GREATER_EQUAL}   { return new Symbol(sym.GREATER_EQUAL, yytext()); }
{EQUALEQUAL}      { return new Symbol(sym.EQUALEQUAL, yytext()); }
{DIF}             { return new Symbol(sym.DIF, yytext()); }
{POT}             { return new Symbol(sym.POT, yytext()); }
{AND}             { return new Symbol(sym.AND, yytext()); }
{OR}              { return new Symbol(sym.OR, yytext()); }
{NOT}             { return new Symbol(sym.NOT, yytext()); }
{BAR}             { return new Symbol(sym.BAR, yytext()); }
{DOTDOT}          { return new Symbol(sym.DOTDOT, yytext()); }

// Delimitadores

{LPAREN}          { return new Symbol(sym.LPAREN, yytext()); }
{RPAREN}          { return new Symbol(sym.RPAREN, yytext()); }
{LBRACKET}        { return new Symbol(sym.LBRACKET, yytext()); }
{RBRACKET}        { return new Symbol(sym.RBRACKET, yytext()); }
{LBRACE}          { return new Symbol(sym.LBRACE, yytext()); }
{RBRACE}          { return new Symbol(sym.RBRACE, yytext()); }
{COMMA}           { return new Symbol(sym.COMMA, yytext()); }
{SEMICOLON}      { return new Symbol(sym.SEMICOLON, yytext()); }
{COLON}           { return new Symbol(sym.COLON, yytext()); }
{CRASIS}          { return new Symbol(sym.CRASIS, yytext()); }
{LEFT_ARROW}      { return new Symbol(sym.LEFT_ARROW, yytext()); }




{LINE_COMMENT}   { /* Ignora comentários de linha */ }

{DELIM_OPEN} {
    blockCommentLevel++; // Incrementa o nível de aninhamento
    yybegin(BLOCK_COMMENT);
}

<BLOCK_COMMENT> {
    {DELIM_OPEN} {
        blockCommentLevel++; // Incrementa o nível de aninhamento
    }
    {DELIM_CLOSE} {
        blockCommentLevel--; // Decrementa o nível de aninhamento
        if (blockCommentLevel == 0) {
            yybegin(YYINITIAL); // Retorna ao estado inicial
        }
    }
    {ANY} {
        // Consome caracteres que não fazem parte dos delimitadores
    }
    . {
        // Consome qualquer outro caractere
    }
}

{WHITESPACE} { /* Ignora espaços em branco */ }

. { throw new RuntimeException("Caractere inválido: " + yytext() + " na linha " + (yyline + 1) + " coluna " + (yycolumn + 1)); }
