using System;

namespace Genetic_Algorithms
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			GeneticAlgorithm ga = new GeneticAlgorithm(1000, 2, new MinimizeSumEvaluator(), 0.001f,25);

			int lowest = -1;
			int i = 0;

			while (lowest == -1)
			{
				lowest = ga.NextGen();
				i++;
			}



			if (lowest != -1)
			{
				Console.WriteLine("Solution in "+i+" gen. : x=" + ga.currentGeneration[lowest].Get(0).ToString("F1") + ", y=" + ga.currentGeneration[lowest].Get(1).ToString("F1"));
			}
			else {
				Console.WriteLine("No Solution");
			}


			
		}
	}
}
