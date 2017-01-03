using System;

namespace Differential_Evolution
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			DE_Algorithm algorithm = new DE_Algorithm(16, 3);
			//algorithm.Print();

			for (int i = 0; i < 100000; i++)
			{
				algorithm.NextGen();
				//algorithm.Print();
				if (algorithm.Done()) break;
			}


		}
	}
}
