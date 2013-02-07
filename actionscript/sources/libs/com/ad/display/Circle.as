package com.ad.display {
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public class Circle extends Leprechaun {
		private var _color:uint;
		private var _radius:Number;
		
		public function Circle(color:uint = 0x0, radius:Number = 1) {
			this._color = color;
			this._radius = radius;
			this.draw();
		}
		
		private function draw():void {
			super.graphics.clear();
			super.graphics.beginFill(this._color);
			super.graphics.drawCircle(0, 0, this._radius);
			super.graphics.endFill();
		}
		
		override public function toString():String {
			return '[Circle ' + super.name + ']';
		}
	}
}