package base.background {
	import soulwire.display.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.net.*;

	public final class Plane extends Sprite {
		private var _paperSprite:PaperSprite;
		private var _container:Sprite;
		private var _shapeFront:Sprite;
		private var _shapeBack:Sprite;
		private var _shape:Sprite;

		public function Plane() {
			create();
		}

		public function get container():PaperSprite {
			return _paperSprite;
		}

		private function create():void {
			_shape = new Sprite();
			_shapeFront = new Sprite();
			_shapeBack = new Sprite();
			_container = new Sprite();
			_paperSprite = new PaperSprite();
			_paperSprite.pivot = new Point(0.5, 0.5);
			addChild(_container);
			addChild(_paperSprite);
		}

		private function createShape():Sprite {
			_shape.graphics.clear();
			_shape.graphics.beginFill(0, 1);
			_shape.graphics.endFill();
			return _shape;
		}

		private function createFrontFace():Sprite {
			_shape.graphics.clear();
			_shapeFront.graphics.clear();
			_shapeFront.graphics.lineStyle(2);
			_shapeFront.graphics.endFill();
			return _shapeFront;
		}

		private function createBackFace():Sprite {
			_shapeBack.graphics.clear();
			_shapeBack.graphics.lineStyle(1);
			_shapeBack.graphics.endFill();
			return _shapeBack;
		}
	}
}