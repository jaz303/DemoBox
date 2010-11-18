package
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	
	import uk.co.jasonframe.demo_box.Demo;
	import uk.co.jasonframe.math.Vec2;
	
	import com.bit101.components.Label;
	import com.bit101.components.HSlider;

	public class FOV extends Demo
	{
		private var _guard:Thing	= null;
		private var _rotate:int 	= 0;
		private var _prey:Array		= [];
		
		protected override function getName():String {
			return "Field of View Demo";
		}
		
		protected override function setup():void {
			
			var label:Label = new Label(controls, PADDING, 26, "FOV");
			
			var slider:HSlider = new HSlider(controls, PADDING, 43, handleFOV);
			slider.backClick = true;
			slider.minimum = 0;
			slider.maximum = 360;
			slider.tick = 20;
			slider.value = 90;
			slider.setSize(CONTROLS_INNER_WIDTH, 10);
			
			_guard = new Thing();
			_guard.position = new Vec2(world.width / 2, world.height / 2);
			_guard.color = 0xff0000;
			world.addChild(_guard);
			
			for (var i:int = 0; i < 20; i++) {
				var p:Thing = new Thing();
				p.position = new Vec2(Math.random() * world.width, Math.random() * world.height);
				p.color = 0x00ff00;
				p.fov = 0;
				world.addChild(p);
				_prey.push(p);
			}
			
		}
		
		protected function handleFOV(e:Event):void {
			_guard.fov = e.target.value;
		}

		protected override function tick(e:Event):void {
			_guard.heading = Vec2.north()._rotateDeg(_rotate += 3);
			var h:Vec2;
			for (var i:int = 0; i < _prey.length; i++) {
				var p:Thing = _prey[i];
				if (_guard.hasInFOV(p)) {
					p.color = 0x0000ff;
				} else {
					p.color = 0x00ff00;
				}
			}
		}
	}
}