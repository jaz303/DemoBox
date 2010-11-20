package uk.co.jasonframe.math
{	
	// Based on the 'The Beauty of Response Curves' by Bob Alexander
	// As found in AI Game Programming Wisdom (vol. 1)
	public class ResponseCurve
	{
		private var _bucketCount:Number;
		
		private var _samples:Array			= [];
		
		private var _min:Number;
		private var _max:Number;
		private var _range:Number;
		private var _step:Number;
		
		public function get min():Number { return _min; }
		public function get max():Number { return _max; }

		public function ResponseCurve(min:Number, max:Number, sampleCountOrArray:Object, sampler:Function = null) {
			_min = min;
			_max = max;

			var i:int;
			if (sampler != null) {
				var sampleCount:Number = sampleCountOrArray as Number;
				_bucketCount = sampleCount - 1;
				_samples = [];
				_step = (_max - _min) / _bucketCount;
				for (i = 0; i < sampleCount; i++) {
					_samples[i] = sampler(_min + (i * _step));
				}
			} else {
				var samples:Array = sampleCountOrArray as Array;
				_bucketCount = samples.length - 1;
				_step = (_max - _min) / _bucketCount;
				for (i = 0; i < samples.length; i++) {
					_samples[i] = samples[i];
				}
			}
		}
		
		public function eval(x:Number):Number {
			var bi:Number = Math.floor((x - _min) / _step);
			
			if (bi <= 0) {
				return _samples[0];
			} else if (bi >= _bucketCount) {
				return _samples[_bucketCount];
			}
			
			var t:Number = (x - (bi * _step)) / _step;
			return ((1 - t) * _samples[bi]) + (t * _samples[bi + 1]);
		}
	}
}