using System;
namespace Differential_Evolution
{
	public class DE_Algorithm
	{
		int numVectors;
		int vectorLength;
		int gen;

		DE_Vector[] vectors;

		public DE_Algorithm(int numVectors, int vectorLength)
		{
			this.numVectors = numVectors;
			this.vectorLength = vectorLength;

			vectors = new DE_Vector[numVectors];
			for (int i = 0; i < numVectors; i++)
			{
				vectors[i] = new DE_Vector(vectorLength);
				vectors[i].Initialize();
			}
			gen = 0;
		}

		public void Print()
		{
			Console.WriteLine("GEN " + gen);
			for (int i = 0; i < numVectors; i++)
			{
				//vectors[i].Print();
				Console.WriteLine(vectors[i].Cost());
			}

		}

		public bool Done()
		{
			for (int i = 0; i < numVectors; i++)
			{
				if (vectors[i].Cost() <= 0.000001)
				{
					Console.WriteLine("DONE: gen "+gen+" i = " + i+" fitness = "+vectors[i].Cost());
					vectors[i].Print();
					return true;
				}
			}
			return false;
		}

		public void NextGen()
		{
			DE_Vector[] newVectors = new DE_Vector[numVectors];
			float factor = 1;
			float cr = 0.5f;
			for (int i = 0; i < numVectors; i++)
			{
				int r1, r2, r3;
				do
				{
					r1 = StaticRandom.Instance.Next(0, numVectors);
					r2 = StaticRandom.Instance.Next(0, numVectors);
					r3 = StaticRandom.Instance.Next(0, numVectors);
				} while (r1 == i || r2 == i || r2 == i || r1 == r2 || r2 == r3 || r3 == r1);
				DE_Vector mutant = vectors[r1].Add(vectors[r2].Sub(vectors[r3]).Scale(factor));
				DE_Vector trial = new DE_Vector(vectorLength);
				int randIndex = StaticRandom.Instance.Next(0, vectorLength);
				for (int j = 0; j < vectorLength; j++)
				{
					float rand = (float) StaticRandom.Instance.NextDouble();
					if (rand <= cr || j == randIndex)
					{
						trial.values[j] = mutant.values[j];
					}
					else
					{
						trial.values[j] = vectors[i].values[j];
					}
				}
				if (trial.Cost() < vectors[i].Cost())
				{
					newVectors[i] = trial;
				}
				else
				{
					newVectors[i] = vectors[i];
				}
			}
			vectors = newVectors;
			gen++;
		}
	}
}
