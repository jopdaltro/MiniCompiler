// Classe Node (nó base)
package src;

import java_cup.runtime.Symbol;

public abstract class Node {
    public abstract void print(String indent);
}

// Classe para declaração "if"
class IfNode extends Node {
    private Symbol ifSym, thenSym, elseSym;
    private Node expr, thenStmt, elseStmt;

    public IfNode(Symbol ifSym, Node expr, Symbol thenSym, Node thenStmt, Node elseStmt) {
        this.ifSym = ifSym;
        this.expr = expr;
        this.thenSym = thenSym;
        this.thenStmt = thenStmt;
        this.elseStmt = elseStmt;
    }

    @Override
    public void print(String indent) {
        System.out.println(indent + "If");
        expr.print(indent + "  ");
        thenStmt.print(indent + "  ");
        if (elseStmt != null) {
            System.out.println(indent + "Else");
            elseStmt.print(indent + "  ");
        }
    }
}

// Classe para expressão
class ExprNode extends Node {
    private Symbol id, equals, num;

    public ExprNode(Symbol id, Symbol equals, Symbol num) {
        this.id = id;
        this.equals = equals;
        this.num = num;
    }

    @Override
    public void print(String indent) {
        System.out.println(indent + "Expr: " + id.value + " = " + num.value);
        }
}