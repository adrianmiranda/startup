package com.nodename.geom {
	import flash.geom.Point;

	public final class Polygon {
		private var _vertices:Vector.<Point>;

		public function Polygon(vertices:Vector.<Point>) {
			this._vertices = vertices;
		}

		public function area():Number {
			return Math.abs(this.signedDoubleArea() * 0.5);
		}

		public function winding():Winding {
			var signedDoubleArea:Number = this.signedDoubleArea();
			if (signedDoubleArea < 0) {
				return Winding.CLOCKWISE;
			}
			if (signedDoubleArea > 0) {
				return Winding.COUNTERCLOCKWISE;
			}
			return Winding.NONE;
		}

		private function signedDoubleArea():Number {
			var index:uint, nextIndex:uint;
			var n:uint = this._vertices.length;
			var point:Point, next:Point;
			var signedDoubleArea:Number = 0;
			for (index = 0; index < n; ++index) {
				nextIndex = (index + 1) % n;
				point = this._vertices[index] as Point;
				next = this._vertices[nextIndex] as Point;
				signedDoubleArea += point.x * next.y - next.x * point.y;
			}
			return signedDoubleArea;
		}
	}
}