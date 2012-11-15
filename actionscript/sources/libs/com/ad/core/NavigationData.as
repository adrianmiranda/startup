package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.Header;
	import com.ad.data.Language;
	import com.ad.errors.ADError;
	
	public class NavigationData extends NavigationCore {
		private var _header:Header;
		private var _lastLanguage:Language;
		private var _language:Language;
		private var _lastView:View;
		private var _view:View;

		public function NavigationData(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):NavigationData {
			if (!hasInstance(key)) instances[key] = new NavigationData(key);
			return instances[key] as NavigationData;
		}

		private function validateHeader(header:Header):void {
			var error:String = '*NavigationData* Header ';
			if (header == null) {
				throw new ADError(error + 'missing required');
			}
			else if (!header.hasViews) {
				throw new ADError(error + 'there is no node view');
			}
		}

		public function registerViews(header:Header):void {
			this.validateHeader(this._header = header);
			this.setLanguage(this.standardLanguage);
			this.setView(this.standardView);
			super.setHistory(header.history);
			super.setTracker(header.track);
			super.setStrict(header.strict);
			super.setTitle(header.title);
		}

		public function createViews(xml:XML):void {
			this.registerViews(new Header(xml, null));
		}

		public function get standardView():View {
			return this.header ? this.views.getView(this.views.root.standard) : null;
		}
		
		public function get mistakeView():View {
			return this.header ? this.views.getView(this.views.root.mistake) : null;
		}
		
		public function get standardLanguage():Language {
			return this.languages ? this.languages.getLanguage(this.languages.standard) : null;
		}
		
		public function get languages():Language {
			return this.header ? this.header.languages : null;
		}
		
		public function get views():View {
			return this.header ? this.header.views : null;
		}

		public function get header():Header {
			return this._header;
		}
		
		public function get language():Language {
			return this._language;
		}
		
		public function get lastView():View {
			return this._lastView;
		}
		
		public function get view():View {
			return this._view;
		}

		public function setLanguage(value:*):Language {
			this._language = value;
			return this._language;
		}

		public function setView(value:*):View {
			this._view = value;
			return this._view;
		}

		protected function createStackTransition(path:String, params:Object = null):void {
			// to override.
		}

		override protected function startup():void {
			this.validateHeader(this.header);
			var params:Object = super.getParameterNames().length ? super.parameters : null;
			var path:String = super.getPath();
			if (super.isHome(path)) {
				this.navigateTo('/home', params);
			} else {
				var view:View = this.header.getView(path);
				if (view) {
					super.setTitle(view.title);
					this.createStackTransition(path, params);
				} else {
					super.navigateTo('/home', params);
				}
			}
		}

		override protected function change():void {
			this.validateHeader(this.header);
			var params:Object = super.getParameterNames().length ? super.parameters : null;
			var path:String = super.getPath() == '/' ? '/home' : super.getPath();
			var view:View = this.header.getView(path);
			if (view) {
				super.setTitle(view.title);
				this.createStackTransition(path, params);
			}
		}

		override public function dispose(flush:Boolean = false):void {
			if (flush) {
				_header = null;
				_lastLanguage = null;
				_language = null;
				_lastView = null;
				_view = null;
			}
			super.dispose(flush);
		}
	}
}