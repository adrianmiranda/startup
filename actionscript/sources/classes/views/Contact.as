package views {
	import com.ad.templates.*;
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
	public final class Contact extends SectionLite {

		public function Contact() {
			super(true);
			super.alpha = 0;
		}

		override public function transitionIn():void {
			super.transitionIn();
			TweenLite.to(this, 0.6, { alpha:1, onComplete:super.transitionInComplete });
		}

		override public function transitionOut():void {
			super.transitionOut();
			TweenLite.to(this, 0.6, { alpha:0, onComplete:super.transitionOutComplete });
		}

		override protected function initialize():void {
			trace('Contact initialised.');
		}

		override protected function finalize():void {
			trace('Contact finalised.');
		}

		override public function arrange():void {
			// N/A yet.
		}
	}
}