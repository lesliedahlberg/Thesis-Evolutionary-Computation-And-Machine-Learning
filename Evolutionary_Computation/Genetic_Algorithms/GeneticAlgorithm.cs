using System;
namespace Genetic_Algorithms
{
	public class GeneticAlgorithm
	{
		int numberOfChromosomes;
		int numberOfGenes;
		int selectionPressure;
		int generation;

		float mutationProbability;

		IEvaluator evaluator;

		public Chromosome[] currentGeneration { get; set;}
		Chromosome[] nextGeneration;

		public GeneticAlgorithm(int numberOfChromosomes, int numberOfGenes, IEvaluator evaluator, float mutationProbability, int selectionPressure)
		{
			generation = 0;
			this.numberOfGenes = numberOfGenes;
			this.numberOfChromosomes = numberOfChromosomes;
			this.mutationProbability = mutationProbability;
			this.selectionPressure = selectionPressure;
			currentGeneration = new Chromosome[numberOfChromosomes];
			nextGeneration = new Chromosome[numberOfChromosomes];
			this.evaluator = evaluator;
			for (int i = 0; i < numberOfChromosomes; i++)
			{
				currentGeneration[i] = new Chromosome(numberOfGenes);
			}
		}

		public void Evaluate()
		{
			for (int i = 0; i < numberOfChromosomes; i++)
			{
				currentGeneration[i].Evaluate(evaluator);
			}
		}

		public void Print()
		{
			
			Console.WriteLine("GENERATION " + generation + ":");
			Console.WriteLine("==============");
			for (int i = 0; i < numberOfChromosomes; i++)
			{
				currentGeneration[i].Print();
			}
		}

		public int Done(double margin)
		{
			double lowest;
			int index;
			lowest = currentGeneration[0].fitness;
			currentGeneration[0].Print();
			index = 0;
			for (int i = 1; i < numberOfChromosomes; i++)
			{
				if (currentGeneration[i].fitness < lowest)
				{
					index = i;
					lowest = currentGeneration[i].fitness;
				}
			}
			if (lowest <= margin)
			{
				return index;
			}
			else {
				return -1;
			}
		}

		public int NextGen()
		{
			int i;
			for (i = 0; i < numberOfChromosomes; i++)
			{
				currentGeneration[i].Evaluate(evaluator);
			}
			Array.Sort(currentGeneration);
			Print();


			int l = Done(0.1f);
			if (l != -1)
			{
				return l;
			}



			int n = 0;
			i = 0;
			int lowerBound = 0;
			int upperBound = (int)(numberOfChromosomes / selectionPressure);
			while (n < numberOfChromosomes)
			{
				int selected1 = StaticRandom.Instance.Next(lowerBound, upperBound);
				int selected2 = StaticRandom.Instance.Next(lowerBound, upperBound);
				nextGeneration[i] = Chromosome.Crossover(currentGeneration[selected1], currentGeneration[selected2]);
				nextGeneration[i].Mutate(mutationProbability);
				i++;
				n++;
			}
			currentGeneration = nextGeneration;
			generation++;
			return l;
		}



	}
}
