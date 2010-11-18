package
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	
	import uk.co.jasonframe.demo_box.Demo;
	import uk.co.jasonframe.demo_box.World;
	
	import uk.co.jasonframe.math.Vec2;

	public class Steering extends Demo
	{
		private var things:Array 	= [];
		private var _ticks:int		= 0;
		private var _prey:Thing		= null;
		private var _preyAngle:Number = 0;
		
		protected override function getName():String {
			return "Steering Demo";
		}
		
		protected override function setup():void {
			
			for (var i:int = 0; i < 20; i++) {
				var t:Thing = new Thing();
				t.position = new Vec2(Math.random() * world.width, Math.random() * world.height);
				t.velocity = (new Vec2(Math.random() * 30 - 15, Math.random() * 30 - 15));
				t.velocity._limit(10);
				//t.heading = (new Vec2(0, 1)).rotateDeg(360 / 10 * -i);
				
				t.mass = 10;
				t.maxForce = 100;
				t.maxSpeed = 10;
				
				world.addChild(t);
				things.push(t);
			}
			
			_prey = new Thing();
			_prey.position = new Vec2(world.width / 2, world.height / 2);
			_prey.color = 0xff0000;
			_prey.velocity = new Vec2(Math.random() * 10, Math.random()* 10);
			world.addChild(_prey);
			
		}
		
		private var seekTarget:Vec2 = new Vec2(500, 300);
		private function seek(t:Thing, target:Vec2):Vec2 {
			
			// desired_velocity = normalize (position - target) * max_speed
			var x:Vec2 = target.dup()._sub(t.position)._normalize()._mul(t.maxSpeed);
			
			// steering = desired_velocity - velocity
			return x._sub(t.velocity);
		
		}
		
		private function flee(t:Thing, target:Vec2):Vec2 {
			var sf:Vec2 = seek(t, target);
			sf._invert();
			return sf;
		}
		
		// this bounces. i'm not sure it's supposed to.
		// gonna look at open steer once i've had a bash at the others
		private function arrive(t:Thing):Vec2 {
			
			var slowingDistance:Number = 200;
			
			var x:Vec2 = seekTarget.dup()._sub(t.position);
			
			var distance:Number = x.length();
			
			var rampedSpeed:Number = t.maxSpeed * (distance / slowingDistance);
			var clippedSpeed:Number = Math.min(t.maxSpeed, rampedSpeed);
			
			return x._mul(clippedSpeed / distance)._sub(t.velocity);
			
		}
		
		// predict the future position of target, from t's perspective
		private function predict(t:Thing, target:Thing):Vec2 {
			
			var distance:Number = t.position.distanceFrom(target.position);
			
			var time:Number = 0;
			if (!t.isInFrontOf(target)) {
				time = distance * 0.113;
			}
			
			var d:Vec2 = target.velocity.dup()._mul(time);
			return target.position.dup()._add(d);
		}
		
		private function pursue(t:Thing, prey:Thing):Vec2 {
			return seek(t, predict(t, prey));
		}
		
		private function evade(t:Thing, prey:Thing):Vec2 {
			return flee(t, predict(t, prey));
		}
		
		protected override function tick(e:Event):void {
			
			_prey.updatePosition();
			
			var target:Vec2 = new Vec2(500, 300);
			
			for (var i:int = 0; i < things.length; i++) {
				
				var thing:Thing = things[i];
				var p1:Vec2 = thing.position.dup();
				
				//
				// Calculate the steering force
				
				var steeringForce:Vec2 = pursue(thing, _prey);
				steeringForce.limit(thing.maxForce);
				
				//
				// Apply steering force
				
				var x:Vec2 = steeringForce.dup();
				
				// acceleration = steering_force / mass
				x._div(thing.mass);					
				
				// velocity = truncate (velocity + acceleration, max_speed)
				x._add(thing.velocity)._limit(thing.maxSpeed);
				thing.velocity = x;
				
				// position = position + velocity
				thing.updatePosition();
				
				thing.redraw();
				with (thing.graphics) {
					lineStyle(1, 0xff0000);
					moveTo(0, 0);
					lineTo(thing.velocity.x, thing.velocity.y);
					lineStyle(1, 0x0000ff);
					moveTo(0, 0);
					lineTo(steeringForce.x, steeringForce.y);
				}
				
				with (world.graphics) {
					lineStyle(1, 0xe0e0e0);
					moveTo(p1.x, p1.y);
					lineTo(thing.position.x, thing.position.y);
				}
				
			}
		}
	}
}