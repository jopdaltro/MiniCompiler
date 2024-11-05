package src;

import java.io.FileReader;
import java.io.IOException;
import java_cup.runtime.Symbol;

public class testLexico {

    public static void main(String[] args) {
        // Caminho do arquivo
        String filename = "C:\\Users\\thelo\\eclipse-workspace\\compilador\\src\\main\\java\\src\\codigo.txt";

        try {
            // Cria um FileReader para ler o arquivo
            FileReader fileReader = new FileReader(filename);
            // Cria o AnalisadorLexico usando o FileReader
            Scanner lexical = new Scanner(fileReader);

            Symbol symbol;
            // Processa os tokens no arquivo até que não haja mais
            while (true) {
                try {
                    symbol = lexical.next_token(); // Usando Symbol diretamente
                    if (symbol == null || symbol.sym == sym.EOF) {
                        break; // Sai do loop se não houver mais tokens ou for EOF
                    }
                    System.out.println("Token Type: " + symbol.sym + ", Token Value: " + symbol.value);
                } catch (RuntimeException e) {
                    // Trata o erro léxico e continua a análise
                    System.err.println("Lexical error: " + e.getMessage());
                }
            }

            // Fecha o FileReader
            fileReader.close();
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
        }
    }
}
