package {
	import com.ad.templates.*;
	import base.background.*;
	import base.header.*;
	import base.footer.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;

	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	public final class Base extends SpriteBase {
		public var background:Background;
		public var header:Header;
		public var footer:Footer;

		public function Base() {
			super();
		}

		override protected function initialize():void {
			
		}

		override protected function finalize():void {
			
		}

		override public function arrange():void {

		}
	}
}