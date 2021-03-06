(function (window, document, undefined) {
	'use strict';

	/*--------------------------------------------------------------------------
	  SWF Helper
	--------------------------------------------------------------------------*/
	
	window.SWF = (function() {
		var _scope;
		var _params;
		var _movie; 
		
		function SWF(movie, params) {
			_scope = this;
			_params = params;
			_movie = movie;
		}

		SWF.prototype.available = function(version) {
			return _scope.has || swfobject.hasFlashPlayerVersion(version || '10.1.00');
		};

		SWF.prototype.get = function (movieName) {
			if (navigator.appName.indexOf('Microsoft') > -1) {
				return window[movieName];
			}
			return document[movieName];
		};

		SWF.prototype.has = function () {
			var playerVersion = swfobject.getFlashPlayerVersion();
			var majorVersion = playerVersion.major;
			return majorVersion != 0;
		};

		SWF.prototype.attach = function(movie, params) {
			_params = (params || _params);
			_movie = (movie || _movie);
			swfobject.addDomLoadEvent(embed);
			return _scope;
		};

		SWF.prototype.detach = function(id) {
			swfobject.removeSWF(id);
			return _scope;
		};

		SWF.prototype.fit = function(id, width, height) {
			if (swffit) {
				swffit.fit(id || 'swf', width || 980, height || 580);
			}
			return _scope;
		}

		function embed(movie, params) {
			movie = (movie || _movie || 'boot.swf');
			params = (params || _params || {});
			
			if (_scope.available(params.version)) {
				var ck = new Date();

				var flashvars = {
					  debug: swfobject.getQueryParamValue('debug')
					, baseContent: '' // path assets as xml, swf..
					, baseService: '' // path services
				};
				
				var settings = {
					  express: flashvars.baseContent+'noflash/support/expressInstall.swf'
					, swf: flashvars.baseContent+movie
					, version: params.version || '10.1.00'
					, div: params.div || 'swf'
					, width: params.width || '100%'
					, height: params.height || '100%'
					, styles: params.styles || ''
				};

				var parameters = {
					  allowScriptAccess: params.allowScriptAccess || 'always'
					, allowFullScreen: params.allowFullScreen || 'true'
					, allowNetworking: params.allowNetworking || 'all'
					, wmode: params.wmode || 'transparent'
				};

				var attributes = {
					  id: settings.div
					, name: settings.div
				};
				
				if (params.width || params.height)
				{
					// TODO: Dinamizar o parent da div do swf e corrigir para outras medidas que não pixels.
					var halfWidth = -(parseFloat(settings.width.split('px').join(''), 10) / 2);
					var halfHeight = -(parseFloat(settings.height.split('px').join(''), 10) / 2);
					var container = document.getElementById('app')
					container.style.width = settings.width
					container.style.height = settings.height
					container.style.marginLeft = halfWidth +'px';
					container.style.marginTop = halfHeight+'px';
					container.style.position = 'absolute';
					container.style.left = '50%';
					container.style.top = '50%';
				}

				var settingsDiv = document.getElementById(settings.div);
				settingsDiv.style.width = settings.width;
				settingsDiv.style.height = settings.height;
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
			}
			return _scope;
		}
		
		return new SWF().attach().fit();
	})();
}(this, document));