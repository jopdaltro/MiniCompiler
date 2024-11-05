package src;

import java.io.FileReader;
import java.io.IOException;
import java_cup.runtime.Symbol;

public class Main {
    public static void main(String[] args) {
        String filename = "C:\\Users\\thelo\\eclipse-workspace\\compilador\\src\\main\\java\\src\\codigo.txt";

        try {
            // Inicializa o analisador léxico com o arquivo de código-fonte
            FileReader fileReader = new FileReader(filename);
            Scanner lexer = new Scanner(fileReader);

            // Inicializa o parser
            Parser p = new Parser(lexer);

            // Executa o parser e obtém o resultado
            Symbol result = p.parse();
            System.out.println("Parsing concluído com sucesso: " + result);

            fileReader.close();
        } catch (Exception e) {
            System.err.println("Erro durante o parsing: " + e.getMessage());
        }
    }
}
