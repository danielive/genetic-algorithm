import com.sun.javafx.fxml.expression.BinaryExpression;
import com.sun.xml.internal.ws.policy.spi.PolicyAssertionValidator;
import io.jenetics.BitChromosome;
import io.jenetics.BitGene;
import io.jenetics.Genotype;
import io.jenetics.engine.Engine;
import io.jenetics.engine.EvolutionResult;
import io.jenetics.util.Factory;
import oracle.jrockit.jfr.events.Bits;

/**
 * @author Daniel Chuev
 *
 * Instance - sin(x)/(1+exp(-x)) where x = [0.5, 10]
 */
public class Main {
    private static double max = 10;
    private static double min = 0.5;
    private static int threshold = 10;
    private static int grid = 15;

    private static double calculateExpression(double x) {
        System.out.println("x:          " + x);

        return (Math.sin(x)) / (1+Math.exp(-x));
    }

    private static String execute() {
        double expression = calculateExpression((Math.random() * (max-min)) + min);

        System.out.println("phenotype:  " + expression);
        System.out.println("chromosome: " + (Long.toBinaryString(Double.doubleToRawLongBits(expression)).substring(0, grid)) + "\n");
        return Long.toBinaryString(Double.doubleToRawLongBits(expression)).substring(0, grid);
    }

    // 2.) Definition of the fitness function.
    private static int eval(Genotype<BitGene> gt) {
        return gt.getChromosome()
                .as(BitChromosome.class)
                .bitCount();
    }

    public static void main(String[] args) {

        for (int i = 0; i < threshold; i++) {
            System.out.println("generation: " + (i+1));
            execute();
        }
    }
}
