using System;
namespace Genetic_Algorithms
{
	interface IGene<Type>
	{
		void Mutate(float probability);
		void Set(Type value);
		Type Get();
	}
}
