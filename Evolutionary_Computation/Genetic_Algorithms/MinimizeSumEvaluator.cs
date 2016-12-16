using System;
namespace Genetic_Algorithms
{
	public class MinimizeSumEvaluator : IEvaluator
	{
		public MinimizeSumEvaluator()
		{
		}

		public double Evaluate(Chromosome chromosome)
		{
			double x = chromosome.Get(0);
			double y = chromosome.Get(1);
			double cost = Math.Sqrt((x) * (x) + (y) * (y));
			return cost;
		}

	}
}
