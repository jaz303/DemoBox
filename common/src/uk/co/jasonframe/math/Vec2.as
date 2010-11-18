package uk.co.jasonframe.math
{	
	public class Vec2
	{
		public const DEG2RAD:Number = Math.PI / 180.0;
		public const RAD2DEG:Number = 180.0 / Math.PI;
		
		public static function zero():Vec2 { return new Vec2(0, 0); }
		public static function make(x:int, y:int):Vec2 { return new Vec2(x, y); }
		
		public static function xAxis():Vec2 { return new Vec2(1, 0); }
		public static function yAxis():Vec2 { return new Vec2(0, 1); }
		
		//
		// Unit vectors for the 4 compass points, assuming north == up
		
		public static function north():Vec2 { return new Vec2(0, -1); }
		public static function south():Vec2 { return new Vec2(0, 1); }
		public static function east():Vec2 { return new Vec2(1, 0); }
		public static function west():Vec2 { return new Vec2(-1, 0); }
		
		public var x:Number;
		public var y:Number;
		
		//
		// Constructor
		
		public function Vec2(x:Number, y:Number) { this.x = x; this.y = y; }
		
		//
		// Copy
		
		public function dup():Vec2 { return new Vec2(x, y); }
		
		//
		// Basic operations, in place
		
		public function _add(v:Vec2):Vec2 { x += v.x; y += v.y; return this; }
		public function _sub(v:Vec2):Vec2 { x -= v.x; y -= v.y; return this; }
		public function _mul(f:Number):Vec2 { x *= f; y *= f; return this; }
		public function _div(f:Number):Vec2 { x /= f; y /= f; return this; }
		
		//
		// Basic operations, return new values
		
		public function add(v:Vec2):Vec2 { return new Vec2(x + v.x, y + v.y); }
		public function sub(v:Vec2):Vec2 { return new Vec2(x - v.x, y - v.y); }
		public function mul(f:Number):Vec2 { return new Vec2(x * f, y * f); }
		public function div(f:Number):Vec2 { return new Vec2(x / f, y / f); }
		
		//
		// Dot product
		
		public function dot(v:Vec2):Number { return (x * v.x) + (y * v.y); }
		
		//
		// Normalize
		
		public function _normalize():Vec2 {
			var i:Number = 1 / length();
			x *= i;
			y *= i;
			return this;
		}
		
		public function normalize():Vec2 {
			var i:Number = 1 / length();
			return new Vec2(x * i, y * i);
		}
		
		//
		// Invert
		
		public function _invert():Vec2 { x = -x; y = -y; return this; }
		public function invert():Vec2 { return new Vec2(-x, -y); }
		
		//
		// Limit
		
		public function _limit(m:Number):Vec2 {
			var ll:Number = x * x + y * y;
			if ((ll > m * m) && ll > 0) {
				var ratio:Number = m / Math.sqrt(ll);
				x *= ratio;
				y *= ratio;
			}
			return this;
		}
		
		public function limit(m:Number):Vec2 {
			var ll:Number = x * x + y * y;
			if ((ll > m * m) && ll > 0) {
				var ratio:Number = m / Math.sqrt(ll);
				return new Vec2(x * ratio, y * ratio);
			} else {
				return new Vec2(x, y);
			}
		}
		
		//
		// Length, length squared
		
		public function length():Number { return Math.sqrt((x * x) + (y * y)); }
		public function lengthSq():Number { return (x * x) + (y * y); }
		
		//
		// Distance, distance squared
		
		public function distanceFrom(v:Vec2):Number {
			return (new Vec2(v.x - x, v.y - y)).length();
		}
		
		//
		// Rotation
		
		public function _rotate(a:Number):Vec2 {
			var s:Number = Math.sin(a), c:Number = Math.cos(a);
			var nx:Number = (x * c) - (y * s);
 			var ny:Number = (y * c) + (x * s);
			x = nx;
			y = ny;
			return this;
		}
		
		public function rotate(a:Number):Vec2 {
			var s:Number = Math.sin(a), c:Number = Math.cos(a);
			return new Vec2(x * c - y * s, y * c + x * s);
		}
		
		public function _rotateDeg(a:Number):Vec2 { return _rotate(a * DEG2RAD); }
		public function rotateDeg(a:Number):Vec2 { return rotate(a * DEG2RAD); }
		
		// Angle from positive x-axis
		// +ve == CCW, -ve == CW
		public function angleX():Number { return Math.atan2(y, x); }
		public function angleXDeg():Number { return Math.atan2(y, x) * RAD2DEG; }
		
		// Angle from positive y-axis
		// +ve == CCW, -ve == CW
		public function angleY():Number { return Math.atan2(-x, y); }
		public function angleYDeg():Number { return Math.atan2(-x, y) * RAD2DEG; }
		
		// Heading (0 == north, 90 == east etc), in degrees
		public function heading():Number { return ((Math.atan2(y, x) * RAD2DEG) + 90) % 360; }
	
	}
}