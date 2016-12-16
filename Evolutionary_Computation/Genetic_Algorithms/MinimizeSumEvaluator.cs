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
			double cost = Math.Sqrt((x+2783) * (x+2783) + (y-1223) * (y-1223));
			return cost;
		}

	}
}
