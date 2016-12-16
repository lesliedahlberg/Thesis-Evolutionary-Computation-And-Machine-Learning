using System;
using System.Globalization;

namespace Genetic_Algorithms
{
	public class Chromosome : IComparable
	{
		public int numberOfGenes { get;}
		Gene[] genes;
		public double fitness { get; set; }

		public Chromosome(int numberOfGenes)
		{
			this.numberOfGenes = numberOfGenes;
			genes = new Gene[numberOfGenes];
			fitness = 0;

			for (int i = 0; i < numberOfGenes; i++)
			{
				genes[i] = new Gene();
				genes[i].Randomize();
			}
		}

		public void Set(int index, double value)
		{
			genes[index].Set(value);
		}

		public double Get(int index)
		{
			return genes[index].Get();
		}

		public double[] GetArray()
		{
			double[] values = new double[numberOfGenes];
			for (int i = 0; i < numberOfGenes; i++)
			{
				values[i] = genes[i].Get();
			}
			return values;
		}

		public void Print()
		{
			if (fitness >= 0) Console.Write(" ");
			Console.Write("["+fitness.ToString("F3", CultureInfo.InvariantCulture)+"] \t\t");
			for (int i = 0; i < numberOfGenes; i++)
			{
				if (Get(i) >= 0) Console.Write(" ");
				Console.Write(Get(i).ToString("F3", CultureInfo.InvariantCulture)+"; \t\t");

			}
			Console.Write("\n");
		}

		public void Mutate(float probability)
		{
			for (int i = 0; i < numberOfGenes; i++)
			{
				genes[i].Mutate(probability);
			}
		}

		public static Chromosome Crossover(Chromosome male, Chromosome female)
		{
			if (male.numberOfGenes != female.numberOfGenes) throw new NotImplementedException();
			Chromosome offspring = new Chromosome(male.numberOfGenes);
			int split = StaticRandom.Instance.Next(0, male.numberOfGenes-1);
			int i;
			for (i = 0; i < split; i++)
			{
				offspring.Set(i, male.Get(i));
			}
			for (; i < male.numberOfGenes; i++)
			{
				offspring.Set(i, female.Get(i));
			}
			return offspring;
		}

		public void Evaluate(IEvaluator evaluator)
		{
			fitness = evaluator.Evaluate(this);
		}

		public int CompareTo(object obj)
		{
			if (obj is Chromosome)
			{
				return this.fitness.CompareTo((obj as Chromosome).fitness);
			}
			throw new ArgumentException("Object is not a Chromosome");
		}
	}
}
