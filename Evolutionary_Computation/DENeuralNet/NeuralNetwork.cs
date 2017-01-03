using System;
namespace DENeuralNet
{
	public class NeuralNetwork
	{
		int inputs;
		int hidden;
		int outputs;

		float[] hiddenWeights;
		float[] outputWeights;

		public NeuralNetwork(int inputs, int hidden, int outputs)
		{
			this.inputs = inputs;
			this.hidden = hidden;
			this.outputs = outputs;

			hiddenWeights = new float[
		}
	}
}
