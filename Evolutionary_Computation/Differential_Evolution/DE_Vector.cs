using System;
namespace Differential_Evolution
{
	public class DE_Vector
	{
		int numValues;
		public float[] values;

		public DE_Vector(int numValues)
		{
			this.numValues = numValues;
			values = new float[numValues];
		}

		private static float RandomNumberBetween(float minValue, float maxValue)
		{
			var next = (float) StaticRandom.Instance.NextDouble();

			return minValue + (next * (maxValue - minValue));
		}

		public void Initialize()
		{
			for (int i = 0; i < numValues; i++)
			{
				values[i] = RandomNumberBetween(-5.12f, 5.12f);
			}
		}

		public DE_Vector Mult(DE_Vector v)
		{
			DE_Vector newVector = new DE_Vector(numValues);
			for (int i = 0; i < numValues; i++)
			{
				newVector.values[i] = this.values[i] * v.values[i];
			}
			return newVector;
		}

		public DE_Vector Add(DE_Vector v)
		{
			DE_Vector newVector = new DE_Vector(numValues);
			for (int i = 0; i < numValues; i++)
			{
				newVector.values[i] = this.values[i] + v.values[i];
			}
			return newVector;
		}

		public DE_Vector Sub(DE_Vector v)
		{
			DE_Vector newVector = new DE_Vector(numValues);
			for (int i = 0; i < numValues; i++)
			{
				newVector.values[i] = this.values[i] - v.values[i];
			}
			return newVector;
		}

		public DE_Vector Scale(float scale)
		{
			DE_Vector newVector = new DE_Vector(numValues);
			for (int i = 0; i < numValues; i++)
			{
				newVector.values[i] = this.values[i] * scale;
			}
			return newVector;
		}

		public float Cost()
		{

			return (float)(Math.Pow(values[0], 2) + Math.Pow(values[1], 2) + Math.Pow(values[2], 2));

			//return (float) ( Math.Pow(values[0], 8) + Math.Pow(values[1], 6) + Math.Pow(values[2], 4) + Math.Pow(values[3], 2) );


			/*float cost = 0;
			for (int i = 0; i < numValues; i++)
			{
				cost += values[i];
			}
			return cost > 0 ? cost : - cost;*/
		}

		public void Print()
		{
			for (int i = 0; i < numValues; i++)
			{
				Console.Write(values[i]+" ");
			}
			Console.WriteLine("");
		}
	}
}
