using System;
namespace Genetic_Algorithms
{
	public class Gene : IGene<double>
	{
		double value;

		public Gene()
		{
		}

		private static double RandomNumberBetween(double minValue, double maxValue)
		{
			var next = StaticRandom.Instance.NextDouble();

			return minValue + (next * (maxValue - minValue));
		}

		public void Randomize()
		{
			//double mantissa = (StaticRandom.Instance.NextDouble() * 2.0) - 1.0;
			//double exponent = Math.Pow(2.0, StaticRandom.Instance.Next(-126, 128));
			//value = mantissa * exponent;
			value = RandomNumberBetween(-1000, 1000);
		}

		public void Mutate(float probability)
		{
			float p = probability * 100;
			float r = StaticRandom.Instance.Next(0, 100);
			if (r <= p)
			{
				double change = RandomNumberBetween(-value, value);
				value += change;
			}
		}

		public void Set(double value)
		{
			this.value = value;
		}

		public double Get()
		{
			return value;
		}
	}
}
