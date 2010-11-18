package uk.co.jasonframe.firedoom
{	
	class GameObject
	{
		private static _nextId:int = 1;
		
		private var _id:int = null;
		public function get id():int { return _id; }
		
		private var _tag:String = null;
		public function get tag():String { return _tag; }
		public function set tag(s:String):void { _tag = s; }
		
		private var _entity:Entity = null;
		public function get entity():Entity { return _entity; }
		public function set entity(e:Entity):void { _entity = e; }
		
		public function GameObject(tag:String = null) {
			_id = (_nextId++);
			_tag = tag;
		}
	}
}