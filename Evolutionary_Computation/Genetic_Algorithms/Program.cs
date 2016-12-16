using System;

namespace Genetic_Algorithms
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			GeneticAlgorithm ga = new GeneticAlgorithm(8, 2, new MinimizeSumEvaluator(), 0.5f, 2);

			int lowest = -1;
			int i = 0;

			while (lowest == -1 && i < 100)
			{
				lowest = ga.NextGen();
				i++;
			}



			if (lowest != -1)
			{
				Console.WriteLine("Solution in "+i+" it. : x=" + ga.currentGeneration[lowest].Get(0) + "y=" + ga.currentGeneration[lowest].Get(1));
			}
			else {
				Console.WriteLine("No Solution");
			}


			
		}
	}
}
