package uk.co.jasonframe.demo_box
{	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	
	public class Demo extends Sprite
	{
		protected const CONTROLS_WIDTH:int			= 250;
		protected const CONTROLS_INNER_WIDTH:int	= 230;
		protected const PADDING:int					= 10;
		
		protected var controls:Panel			= null;
		protected var world:World				= null;
		
		public function Demo() {
			configureStage();
			buildUI();
			setup();
			
			stage.addEventListener(Event.RESIZE, layout);
			stage.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function configureStage():void {
			stage.frameRate = 30.0;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		private function buildUI():void {
			
			controls = new Panel();
			controls.x = PADDING;
			controls.y = PADDING;
			addChild(controls);
			
			var label:Label = new Label(controls, 5, 5, getName());
			
			world = new World();
			world.x = CONTROLS_WIDTH + (PADDING * 2);
			world.y = PADDING;
			addChild(world);
			
			layout(null);
		}
		
		private function layout(e:Event):void {
			var ww:int = stage.stageWidth - (3 * PADDING) - CONTROLS_WIDTH;
			var wh:int = stage.stageHeight - (2 * PADDING);
			
			controls.setSize(CONTROLS_WIDTH, wh);
			
			world.setSize(ww, wh);
			world.scrollRect = new Rectangle(0, 0, ww + 2, wh + 2);
		}
		
		//
		// Overridable hooks
		
		protected function getName():String {
			return "Demo";
		}
		
		protected function setup():void {
			
		}
		
		protected function tick(e:Event):void {
			
		}
	}
}