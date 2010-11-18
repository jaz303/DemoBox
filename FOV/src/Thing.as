package
{	
	import flash.display.Sprite;
	import flash.display.GradientType;
	import uk.co.jasonframe.math.Vec2;
	
	public class Thing extends Sprite
	{
		private const RADIUS:int = 10;
		private const FOV_SIZE:int = 100;
		
		private var _mass		: Number		= 1;
		private var _position	: Vec2			= new Vec2(0, 0);
		private var _velocity	: Vec2			= new Vec2(0, 0);
		private var _maxForce	: Number		= 0;
		private var _maxSpeed	: Number		= 0;
		private var _heading	: Vec2			= new Vec2(1, 0);
		private var _color		: int			= 0xa0ffa0;
		private var _fov		: Number		= 90.0;
	
		public function get mass():Number { return _mass; }
		public function set mass(m:Number):void { _mass = m; }
		
		public function get position():Vec2 { return _position; }
		public function set position(p:Vec2):void { _position = p; x = p.x; y = p.y; }
		
		public function get velocity():Vec2 { return _velocity; }
		public function set velocity(v:Vec2):void { _velocity = v; }
		
		public function get maxForce():Number { return _maxForce; }
		public function set maxForce(mf:Number):void { _maxForce = mf; }
		
		public function get maxSpeed():Number { return _maxSpeed; }
		public function set maxSpeed(ms:Number):void { _maxSpeed = ms; }
		
		public function get heading():Vec2 { return _heading; }
		public function set heading(h:Vec2):void { _heading = h; rotation = h.heading(); }
		
		public function get color():int { return _color; }
		public function set color(c:int):void { _color = c; redraw(); }
		
		public function get fov():Number { return _fov; }
		public function set fov(c:Number):void { _fov = c; redraw(); }
		
		//
		// Predicates
		
		// returns true if other in this thing's FOV
		public function hasInFOV(other:Thing):Boolean {
			
			var meToOther:Vec2 = other.position.dup()._sub(position)._normalize();
			var h:Vec2 = heading.dup()._normalize();
			
			var dot:Number = h.dot(meToOther);
			
			return dot > Math.cos((_fov / 2) * (Math.PI / 180));
		}
		
		
		// http://forum.unity3d.com/threads/53188-how-do-i-detect-if-an-object-is-in-front-of-another-object
		public function isInFrontOf(other:Thing):Boolean {
			
			var heading:Vec2 = position.dup();
			heading.sub(other.position);
			heading.normalize();
			
			var direction:Vec2 = velocity.dup();
			//direction.normalize();
			
			var dot:Number = heading.dot(direction);
			
			return dot > 1;
		}
		
		//
		// Constructor
		
		public function Thing() {
			redraw();
		}
		
		public function updatePosition():void {
			this.position.x += this.velocity.x;
			this.position.y += this.velocity.y;
			this.x = this.position.x;
			this.y = this.position.y;
		}
		
		public function redraw():void {
			with (this.graphics) {
				clear();
				
				if (fov > 0) {
					beginGradientFill(GradientType.RADIAL, [_color, _color], [0.15, 0], [0, 255]);
					drawSlice(0, 0, FOV_SIZE, -_fov / 2 - 90, _fov);
					endFill();
				}
				
				beginFill(_color, 1);
				drawCircle(0, 0, RADIUS);
				endFill();
			}
		}
		
		/**
		 *	Draw a circle slice
		 *	x0				slice center x position
		 *	y0				slice center y position
		 *	r				radius
		 *	startingAngle	in degrees, 0 = 3 o'clock
		 *	arcAngle		in degrees, draws clockwise.
		 */
		private function drawSlice(x0:Number, y0:Number, r:Number, startAngle:Number, arcAngle:Number):void
		{
			var deg2rad:Number = Math.PI / 180.0;
			var angle:Number;
			var arcStep:Number = 5;
			var steps:Number = arcAngle / arcStep;
			var x1:Number = x0 + Math.cos(startAngle * deg2rad) * r;
			var y1:Number = y0 + Math.sin(startAngle * deg2rad) * r;
			
			graphics.moveTo(x0, y0);
			graphics.lineTo(x1, y1);
			
			for (var i:int = 1; i <= steps; i++)
			{
				angle = (startAngle + i * arcStep) * deg2rad;
				x1 = x0 + Math.cos(angle) * r;
				y1 = y0 + Math.sin(angle) * r;
				graphics.lineTo(x1, y1);
			}
			graphics.lineTo(x0, y0);
		}
	}
}