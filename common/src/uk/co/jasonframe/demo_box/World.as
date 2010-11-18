package uk.co.jasonframe.demo_box
{	
	import flash.display.Sprite;
	
	public class World extends Sprite
	{
		private var _width:int;
		private var _height:int;
		
		public function setSize(width:int, height:int):void {
			_width = width;
			_height = height;
			redraw();
		}
		
		private function redraw():void {
			with (graphics) {
				clear();
				lineStyle(1, 0xe0e0e0);
				drawRect(0, 0, _width, _height);
			}
		}
	}
}