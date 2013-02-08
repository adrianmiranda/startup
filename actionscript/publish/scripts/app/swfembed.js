(function (window, document, undefined) {
	'use strict';

	window.SWF = (function() {

		SWF.prototype.available = function() {
			return this.has || swfobject.hasFlashPlayerVersion('6.0.65');
		};

		SWF.prototype.get = function (movieName) {
			if (navigator.appName.indexOf('Microsoft') > -1) {
				return window[movieName];
			} else {
				return document[movieName];
			}
		};

		SWF.prototype.has = function () {
			var playerVersion = swfobject.getFlashPlayerVersion();
			var majorVersion = playerVersion.major;
			return majorVersion != 0;
		};

		SWF.prototype.embed = function(swf, params) {
			params = params || {};

			var ck = new Date();

			var flashvars = {
				  debug: swfobject.getQueryParamValue('debug')
				, fvBaseContent: '' // path assets as xml, swf
				, fvBaseService: '' // path services
			};

			var settings = {
				  express: flashvars.fvBaseContent+'noflash/support/expressInstall.swf'
				, swf: flashvars.fvBaseContent+(params.swf || 'boot.swf')
				, version: params.version || '10.1.00'
				, div: params.div || 'flash'
				, width: params.width || '100%'
				, height: params.height || '100%'
			};

			var parameters = {
				  allowscriptaccess: 'always'
				, allowFullScreen: 'true'
				, allownetworking: 'all'
				, wmode: 'transparent'
			};

			var attributes = {
				  id: settings.div
				, name: settings.div
			};

			swfobject.createCSS('html', 'width:'+settings.width+';height:'+settings.height+';margin:0;padding:0;overflow:hidden;');
			swfobject.createCSS('body', 'width:'+settings.width+';height:'+settings.height+';margin:0;padding:0;overflow:hidden;');
			swfobject.createCSS('.wrapper', 'width:'+settings.width+';height:'+settings.height+';position:relative;margin:0 auto;');
			swfobject.createCSS('#'+settings.div, 'width:'+settings.width+';height:'+settings.height+';margin:0;');
			swfobject.embedSWF(
				  settings.swf+'?ck='+ck.getTime()
				, settings.div
				, settings.width
				, settings.height
				, settings.version
				, settings.express+'?ck='+ck.getTime()
				, flashvars
				, parameters
				, attributes
			);
			
			if (swffit) {
				swffit.fit(attributes.id, params.fitX || 980, params.fitY || 550);
			}
		};

		function SWF() {
			if (this.available()) {
				swfobject.addDomLoadEvent(this.embed);
			} else {
				window.location = 'noflash/index.html';
			}
		}

		return new SWF();
	})();

}(this, document));
