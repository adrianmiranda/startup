package {
	import com.ad.templates.*;
	import com.ad.common.*;
	import com.ad.events.*;
	import com.ad.utils.*;
	import com.ad.data.*;
	import com.ad.core.*;
	import com.ad.net.*;
	import com.ad.ui.*;
	import com.greensock.loading.*;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import com.greensock.events.*;
	import com.greensock.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	import base.typography.*;
	import views.*;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	[SWF(width='550', height='400', frameRate='31', backgroundColor='#dddddd')]
	public final class Boot extends SpriteBase {
		private var _cmmenu:ContextMenuManager;
		private var _app:Application;

		public function Boot() {
			super(true, false, null);
		}

		override protected function initialize():void {
			_cmmenu = new ContextMenuManager(this, true);
			_app = Application.getInstance();
			_app.plugins(AutoAlphaPlugin);
			_app.loaders(XMLLoader, SWFLoader);
			_app.classes(Base, Home, About, Contact);
			_app.addEventListener(LoaderEvent.PROGRESS, progress);
			_app.addEventListener(LoaderEvent.COMPLETE, complete);
			_app.fromXML('{@fvBaseContent}content/settings/sitemap.xml');
			_app.onReady = ready;
			_app.startup(this);
		}

		override protected function finalize():void {
			_app.dispose(true);
			_app = null;
		}

		override public function arrange():void {
			// N/A yet.
		}

		private function ready():void {
			_app.layers('layers');
		}

		private function progress(event:LoaderEvent):void {
			trace(sprintf('%03d', Math.round(event.target.progress * 100))+'%');
		}

		private function complete(event:LoaderEvent):void {
			Fonts.registerFonts();
			run();
		}

		private function run():void {
			_app.params('parameters').tracks('tracks').links('links').texts('texts').run('view');
			_cmmenu.add(i18n('byline'), onClickByline);
			_cmmenu.add('about', onClickAbout, true);
			_cmmenu.add('contact', onClickContact);
		}
		
		private function onClickByline(event:ContextMenuEvent):void {
			Browser.gotoURL('https://github.com/adrianmiranda', '_blank');
		}

		private function onClickAbout(event:ContextMenuEvent):void {
			Browser.gotoURL('http://cargocollective.com/adrianmiranda', '_blank');
		}

		private function onClickContact(event:ContextMenuEvent):void {
			Browser.mailTo('adriancmiranda@gmail.com', 'ad::feedback');
		}
	}
}