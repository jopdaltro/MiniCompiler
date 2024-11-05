package src;

import java.io.FileReader;
import java.io.IOException;
import java_cup.runtime.Symbol;

public class ParserTest {

    public static void main(String[] args) {
        // Caminho do arquivo
        String filename = "C:\\Users\\thelo\\eclipse-workspace\\compilador\\src\\main\\java\\src\\codigo.txt";

        try {
            // Cria um FileReader para ler o arquivo
            FileReader fileReader = new FileReader(filename);
            // Cria o AnalisadorLexico usando o FileReader
            Scanner lexical = new Scanner(fileReader);
            // Cria uma instância do parser
            Parser parser = new Parser(lexical); // Substitua "Parser" pelo nome da sua classe de parser

            try {
                // Inicia a análise sintática
                parser.parse(); // Chama o método de parse que processa os tokens
                System.out.println("Parsing completed successfully.");
            } catch (Exception e) {
                // Trata exceções lançadas durante a análise sintática
                System.err.println("Parsing error: " + e.getMessage());
            }

            // Fecha o FileReader
            fileReader.close();
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
        }
    }
}
