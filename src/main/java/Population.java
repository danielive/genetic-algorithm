/**
 * @author Daniel Chuev
 */
public class Population {

    private Individual[] individuals;

    public Population(int populationSize) {
        individuals = new Individual[populationSize];
    }
//
//    public void initialize() {
//        for (int i = 0; i < Individual.lenght; i++) {
//            Individual newIndividual = new Individual();
//            newIndividual.generateIndividual();
//            saveIndividual(i, newIndividual);
//        }
//    }
//
//    public Individual getIndividual(int index) {
//        return this.individuals[index];
//    }
//
//    public Individual getFitnessIndividual() {
//        Individual fitness = individuals[0];
//
//        for (int i = 0; i < individuals.length; ++i) {
//            if (getIndividual(i).getFitness() >= fitness.getFitness())
//                fitness = getIndividual(i);
//        }
//
//        return fitness;
//    }


}
