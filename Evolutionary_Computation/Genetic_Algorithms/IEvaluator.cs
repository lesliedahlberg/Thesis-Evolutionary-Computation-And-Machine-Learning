using System;
namespace Genetic_Algorithms
{
	public interface IEvaluator
	{
		 double Evaluate(Chromosome chromosome);
	}
}
