(function (window, document, undefined) {
	'use strict';

	window.SWF = (function() {

		var flashvars = {
			  debug: swfobject.getQueryParamValue('debug')
			, fvBaseContent: '' // path assets as xml, swf
			, fvBaseService: '' // path services
		};

		var settings = {
			  express: flashvars.fvBaseContent+'noflash/expressInstall.swf'
			, swf: flashvars.fvBaseContent+'boot.swf'
			, version: '10.0.000'
			, div: 'flash'
			, width: '100%'
			, height: '100%'
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

		SWF.getSWF = function (movieName) {
			if (navigator.appName.indexOf('Microsoft') > -1) {
				return window[movieName];
			} else {
				return document[movieName];
			}
		};

		SWF.hasSWF = function () {
			var playerVersion = swfobject.getFlashPlayerVersion();
			var majorVersion = playerVersion.major;
			return majorVersion != 0;
		};

		SWF.embed = function() {
			var ck = new Date();
			swfobject.createCSS('html', 'width:'+settings.width+';height:'+settings.height+';margin:0;padding:0;overflow:hidden;');
			swfobject.createCSS('body', 'width:'+settings.width+';height:'+settings.height+';margin:0;padding:0;overflow:hidden;');
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
				swffit.fit(attributes.id, 800, 600);
			}
		};

		function SWF() {
			if (swfobject.hasFlashPlayerVersion('6.0.65')) {
				swfobject.addDomLoadEvent(SWF.embed);
			} else if (!swfobject.hasFlashPlayerVersion('6.0.65')) {
				window.location = 'noflash/getFlash.html';
			}
		}

		return new SWF();
	})();

}(this, document));
