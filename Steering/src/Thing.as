package
{	
	import flash.display.Sprite;
	import uk.co.jasonframe.math.Vec2;
	
	public class Thing extends Sprite
	{
		private const RADIUS:int = 10;
		
		private var _mass		: Number;
		private var _position	: Vec2;
		private var _velocity	: Vec2;
		private var _maxForce	: Number;
		private var _maxSpeed	: Number;
		private var _heading	: Vec2;
		private var _color		: int			= 0xa0ffa0;
		
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
		
		//
		// Predicates
		
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
			this.position = new Vec2(0, 0);
			this.velocity = new Vec2(0, 0);
			this.heading = new Vec2(0, 1);
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
				beginFill(_color, 1);
				drawCircle(0, 0, RADIUS);
				endFill();
				
				/*moveTo(0, 0);
				lineStyle(1.0, 0xff0000);
				lineTo(0, -RADIUS);*/
			}
		}
	}
}
