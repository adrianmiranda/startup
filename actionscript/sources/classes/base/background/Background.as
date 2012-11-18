package base.background {
	import com.greensock.easing.*;
	import com.greensock.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class Background extends Sprite {
		private var _tweenGroup:TimelineLite;

		public function Background() {
			createTweenGroup();
		}

		protected function initialize():void {
			
		}

		protected function finalize():void {
			
		}

		public function arrange():void {

		}

		private function createTweenGroup():void
		{
			_tweenGroup = new TimelineLite();
		}
	}
}