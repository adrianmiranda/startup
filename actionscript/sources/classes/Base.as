package {
	import com.ad.templates.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	import base.background.*;
	import base.header.*;
	import base.footer.*;
	import base.menu.*;

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class Base extends SectionLite {
		public var background:Background;
		public var header:Header;
		public var footer:Footer;
		public var menu:Menu;

		public function Base() {
			super();
		}

		override protected function initialize():void {
			
		}

		override protected function finalize():void {
			
		}
		
		override public function transitionIn():void {
			super.transitionIn();
			super.transitionInComplete();	
		}

		override public function transitionOut():void {
			super.transitionOut();
			super.transitionOutComplete();	
		}

		override public function arrange():void {

		}
	}
}