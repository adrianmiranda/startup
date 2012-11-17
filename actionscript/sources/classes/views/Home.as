package views {
	import com.ad.templates.*;
	import com.greensock.easing.*;
	import com.greensock.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;

	public final class Home extends SectionLite {

		public function Home() {
			super();
		}

		override public function transitionIn():void
		{
			super.transitionIn();
			super.transitionInComplete();
		}

		override public function transitionOut():void
		{
			super.transitionOut();
			super.transitionOutComplete();
		}

		override protected function initialize():void {
			
		}

		override protected function finalize():void {
			
		}

		override public function arrange():void {

		}
	}
}