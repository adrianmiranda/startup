package com.ad.core {
	import com.ad.data.View;
	import com.ad.data.Header;
	import com.ad.data.Language;
	import com.ad.errors.ADError;
	import com.ad.utils.BranchUtils;
	import com.ad.proxy.nsapplication;
	import com.ad.events.ApplicationEvent;
	
	/**
	 * @author Adrian C. Miranda <ad@adrianmiranda.com.br>
	 */
	use namespace nsapplication;
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

		protected function validateHeader(header:Header):void {
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
			this.setStandardLanguage();
			this.setStandardView();
			super.setHistory(header.history);
			super.setTracker(header.track);
			super.setStrict(header.strict);
			super.setTitle(header.title);
		}

		public function isHomePage(value:*):Boolean {
			this.validateHeader(this.header);
			if (value && value is String) {
				value = value.split(this.language.branch).join('');
				value = BranchUtils.arrange(value, false).toLowerCase();
			}
			return (value == this.view || value == this.views.root.branch || value == '/' || value == '');
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
		
		public function get lastLanguage():Language {
			return this._lastLanguage;
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
		
		private function setStandardLanguage():void {
			this._lastLanguage = this.standardLanguage;
			this._language = this.standardLanguage;
		}

		private function setStandardView():void {
			this._lastView = this.standardView;
			this._view = this.standardView;
			super.setTitle(this.view.title);
		}

		public function setLanguage(value:*):Language {
			var locale:Language;
			if (value) {
				this.validateHeader(this.header);
				locale = this.languages.getLanguage(value);
				if (locale) {
					locale = locale.tree;
					if (locale.branch != language.branch) {
						this._lastLanguage = this._language;
						this._language = locale;
						super.dispatchEvent(new ApplicationEvent(ApplicationEvent.CHANGE_LANGUAGE, this.apiKey));
					}
				} else {
					super.setHistory(false);
					super.navigateTo(BranchUtils.arrange(this.language.branch + '/' + this.view.branch));
					super.setHistory(header.history);
				}
			}
			return locale;
		}

		public function setView(value:*):View {
			var section:View;
			if (value) {
				this.validateHeader(this.header);
				if (value is String) {
					value = BranchUtils.arrange(value);
					value = this.isHomePage(value) ? this.standardView.branch : value;
					value = value.split(this.language.branch).join('');
				}
				section = this.header.getView(value) || this.mistakeView;
				if (section) {
					var suffix:String = new String();
					if (value is String && value.indexOf(section.branch) > -1) {
						suffix = value.substr(value.indexOf(section.branch) + section.branch.length, value.length);
					}
					if (section.branch != this.view.branch) {
						this._lastView = this._view;
						this._view = section;
						super.setTitle(this.view.title);
						super.dispatchEvent(new ApplicationEvent(ApplicationEvent.CHANGE_VIEW, this.apiKey));
					}
				}
			}
			return section;
		}

		override public function navigateTo(value:*, query:Object = null):void {
			this.validateHeader(this.header);
			value = BranchUtils.arrange(value);
			var path:String = BranchUtils.cleanup(value);
			var params:String = BranchUtils.getQueryString(value, true);
			var section:View, suffix:String = new String();
			this.setLanguage(path);
			path = path.split(this.language.branch).join('');
			path = this.isHomePage(path) ? this.standardView.branch : path;
			section = header.getView(path) || this.view;
			if (path.indexOf(section.branch) > -1) {
				path = BranchUtils.trimQueryString(path);
				suffix = path.substr(path.indexOf(section.branch) + section.branch.length, path.length);
			}
			super.navigateTo(BranchUtils.arrange(language.branch + '/' + section.branch + suffix + params), query);
		}

		override protected function startup():void {
			this.validateHeader(this.header);
			var params:Object = super.getParameterNames().length ? super.parameters : null;
			var path:String = super.getPath();
			if (this.isHomePage(path)) {
				super.navigateTo(this.standardView.branch, params);
			} else {
				var view:View = this.header.getView(path);
				if (view) {
					this.setView(view);
					super.setTitle(view.title);
					this.setLanguage(view.branch);
					this.stackTransition(view, params);
				} else {
					super.navigateTo(this.standardView.branch, params);
				}
			}
		}

		override protected function change():void {
			this.validateHeader(this.header);
			var params:Object = super.getParameterNames().length ? super.parameters : null;
			var path:String = super.getPath() == '/' ? this.standardView.branch : super.getPath();
			var view:View = this.header.getView(path);
			if (view) {
				this.setView(view);
				super.setTitle(view.title);
				this.setLanguage(view.branch);
				this.stackTransition(view, params);
			} else {
				this.setView(this.mistakeView);
			}
		}

		protected function stackTransition(view:View, params:Object = null):void {
			// to override.
		}

		override public function dispose(flush:Boolean = false):void {
			if (flush) {
				this._header = null;
				this._lastLanguage = null;
				this._language = null;
				this._lastView = null;
				this._view = null;
			}
			super.dispose(flush);
		}

		override public function toString():String {
			return '[NavigationData ' + super.apiKey + ']';
		}
	}
}