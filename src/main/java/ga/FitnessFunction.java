package ga;

public interface FitnessFunction {
	int getArity(); // Количество битов в геноме
	long run(long[] genom); // Фитнесс Функция от генома
}
