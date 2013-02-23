package com.ad.data {
	import com.ad.utils.Binding;
	import com.ad.common.num;
	import com.ad.common.bool;
	import com.ad.errors.ADError;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.LoaderMax;

	import flash.display.DisplayObject;
	
	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com> 
	 */
	public final class File {
		internal namespace nsarmored = 'http://www.adrianmiranda.com.br/com/adframework/core/data/view.nsarmored';
		private var _binding:DisplayObject;
		private var _parent:View;
		private var _ownContext:Boolean;
		private var _runInBackground:Boolean;
		private var _preload:Boolean;
		private var _noCache:Boolean;
		private var _bytes:uint;
		private var _type:String;
		private var _url:String;
		private var _id:String;
		private var _xml:XML;

		// LoaderMax properties - no yet implemented
		private var _loader:LoaderItem;
		private var _integrateProgress:Boolean;
		private var _centerRegistration:Boolean;
		private var _bufferMode:Boolean;
		private var _autoPlay:Boolean;
		private var _scaleMode:String;
		private var _alpha:Number;
		private var _width:Number;
		private var _height:Number;
		private var _crop:Boolean;
		private var _autoDetachNetStream:Boolean;
		private var _allowMalformedURL:Boolean;
		private var _estimatedDuration:Number;
		private var _autoAdjustBuffer:Boolean;
		private var _checkPolicyFile:Boolean;
		private var _initThreshold:uint;
		private var _alternateURL:String;
		private var _autoDispose:Boolean;
		private var _bufferTime:Number;
		private var _deblocking:int;
		private var _smoothing:Boolean;
		private var _blendMode:String;
		private var _rotationX:Number;
		private var _rotationY:Number;
		private var _rotationZ:Number;
		private var _rotation:Number;
		private var _bgColor:uint;
		private var _bgAlpha:Number;
		private var _visible:Number;
		private var _hAlign:String;
		private var _vAlign:String;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _volume:Number;
		private var _repeat:int;
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		// --
		
		public function File(xml:XML, binding:DisplayObject = null) {
			this.validateFileNode(xml);
			this._xml = xml;
			this._binding = binding;
			this._id = xml.@id.toString();
			this._url = this.bind(xml.@url.toString());
			this._ownContext = bool(xml.@ownContext);
			this._type = xml.@type.toString() || this._url.substring(this._url.lastIndexOf('.') + 1, this._url.length);
			this._bytes = ((num(xml.@kb) || 20000 / 1024) * 1024);
			this._preload = xml.@preload != undefined ? bool(xml.@preload) : true;
			this._noCache = xml.@noCache != undefined ? bool(xml.@noCache) : true;

			// LoaderMax properties - no yet implemented
			this._integrateProgress = bool(xml.@integrateProgress);
			this._centerRegistration = bool(xml.@centerRegistration);
			this._bufferMode = bool(xml.@bufferMode);
			this._autoPlay = bool(xml.@autoPlay);
			this._scaleMode = xml.@scaleMode.toString();
			this._alpha = num(xml.@alpha);
			this._width = xml.@width != undefined ? Math.abs(num(xml.@width)) : 320;
			this._height = xml.@height != undefined ? Math.abs(num(xml.@height)) : 240;
			this._crop = bool(xml.@crop);
			this._autoDetachNetStream = bool(xml.@autoDetachNetStream);
			this._allowMalformedURL = bool(xml.@allowMalformedURL);
			this._estimatedDuration = num(xml.@estimatedDuration);
			this._autoAdjustBuffer = bool(xml.@autoAdjustBuffer);
			this._checkPolicyFile = bool(xml.@checkPolicyFile);
			this._initThreshold = uint(num(xml.@initThreshold));
			this._alternateURL = xml.@alternateURL.toString();
			this._autoDispose = bool(xml.@autoDispose);
			this._bufferTime = num(xml.@bufferTime);
			this._deblocking = int(num(xml.@deblocking));
			this._smoothing = bool(xml.@smoothing);
			this._blendMode = xml.@blendMode.toString();
			this._rotationX = num(xml.@rotationX);
			this._rotationY = num(xml.@rotationY);
			this._rotationZ = num(xml.@rotationZ);
			this._rotation = num(xml.@rotation);
			this._bgColor = uint(num(xml.@bgColor));
			this._bgAlpha = num(xml.@bgAlpha);
			this._visible = num(xml.@visible);
			this._hAlign = xml.@hAlign.toString();
			this._vAlign = xml.@vAlign.toString();
			this._scaleX = num(xml.@scaleX);
			this._scaleY = num(xml.@scaleY);
			this._volume = num(xml.@volume);
			this._repeat = int(num(xml.@repeat));
			this._x = num(xml.@x);
			this._y = num(xml.@y);
			this._z = num(xml.@z);
			// --
			
			if (xml.attribute('run-in-background') != undefined) {
				this._preload = false;
				this._runInBackground = bool(xml.attribute('run-in-background'));
			}

			this._loader = LoaderMax.parse(this._url, {
				  //name:this._id
				//, ownContext:(this._parent.ownContext || this._ownContext)
				//, noCache:this._noCache
				// LoaderMax properties - no yet implemented
				//, centerRegistration:this._centerRegistration
				//, bufferMode:this._bufferMode
				//, autoPlay:this._autoPlay
				//, scaleMode:this._scaleMode
				//, alpha:this._alpha
				//, width:this._width
				//, height:this._height
				//, crop:this._crop
				//, autoDetachNetStream:this._autoDetachNetStream
				//, allowMalformedURL:this._allowMalformedURL
				//, estimatedDuration:this._estimatedDuration
				//, autoAdjustBuffer:this._autoAdjustBuffer
				//, checkPolicyFile:this._checkPolicyFile
				//, initThreshold:this._initThreshold
				//, alternateURL:this._alternateURL
				//, autoDispose:this._autoDispose
				//, bufferTime:this._bufferTime
				//, deblocking:this._deblocking
				//, smoothing:this._smoothing
				//, blendMode:this._blendMode
				//, rotationX:this._rotationX
				//, rotationY:this._rotationY
				//, rotationZ:this._rotationZ
				//, rotation:this._rotation
				//, bgColor:this._bgColor
				//, bgAlpha:this._bgAlpha
				//, visible:this._visible
				//, hAlign:this._hAlign
				//, vAlign:this._vAlign
				//, scaleX:this._scaleX
				//, scaleY:this._scaleY
				//, volume:this._volume
				//, repeat:this._repeat
				//, x:this._x
				//, y:this._y
				//, z:this._z
				// --
				//, autoLoad:false
			});
		}
		
		private function validateFileNode(node:XML):void {
			var error:String = '*Invalid Views XML* File ';
			if (node == null) {
				throw new ADError(error + 'node missing required');
			}
			else if (node.@id == undefined) {
				throw new ADError(error + 'node missing required attribute \'id\'');
			}
			else if (!/^([a-zA-Z0-9-_])+$/g.test(node.@id)) {
				throw new ADError(error + node.@id + ' \'id\' attribute contains invalid characters');
			}
			else if (node.@url == undefined) {
				throw new ADError(error + 'node missing required attribute \'url\'');
			}
			else if (!Binding.isValid(node.@url)) {
				throw new ADError(error + node.@id + ' \'url\' attribute contains invalid binding expression \'' + node.@url + '\'');
			}
			else {
				for each (var id:String in node.parent().file.@id) {
					if (node.parent().file.(@id == id).length() > 1) {
						throw new ADError(error + id + ' node duplicate');
					}
				}
			}
		}
		
		private function bind(raw:String):String {
			if (this._binding) {
				raw = Binding.bind(raw, this._binding);
			}
			return raw;
		}

		// LoaderMax properties - no yet implemented
		public function get loader():* {
			return this._loader;
		}

		public function get integrateProgress():Boolean {
			return this._integrateProgress;
		}

		public function get centerRegistration():Boolean {
			return this._centerRegistration;
		}

		public function get bufferMode():Boolean {
			return this._bufferMode;
		}

		public function get scaleMode():String {
			return this._scaleMode;
		}

		public function get autoPlay():Boolean {
			return this._autoPlay;
		}

		public function get autoDetachNetStream():Boolean {
			return this._autoDetachNetStream;
		}

		public function get allowMalformedURL():Boolean {
			return this._allowMalformedURL;
		}

		public function get estimatedDuration():Number {
			return this._estimatedDuration;
		}

		public function get autoAdjustBuffer():Boolean {
			return this._autoAdjustBuffer;
		}

		public function get checkPolicyFile():Boolean {
			return this._checkPolicyFile;
		}

		public function get initThreshold():uint {
			return this._initThreshold;
		}

		public function get alternateURL():String {
			return this._alternateURL;
		}

		public function get autoDispose():Boolean {
			return this._autoDispose;
		}

		public function get bufferTime():Number {
			return this._bufferTime;
		}

		public function get deblocking():int {
			return this._deblocking;
		}

		public function get smoothing():Boolean {
			return this._smoothing;
		}

		public function get blendMode():String {
			return this._blendMode;
		}

		public function get rotationX():Number {
			return this._rotationX;
		}

		public function get rotationY():Number {
			return this._rotationY;
		}

		public function get rotationZ():Number {
			return this._rotationZ;
		}

		public function get rotation():Number {
			return this._rotation;
		}

		public function get bgColor():uint {
			return this._bgColor;
		}

		public function get bgAlpha():Number {
			return this._bgAlpha;
		}

		public function get visible():Number {
			return this._visible;
		}

		public function get hAlign():String {
			return this._hAlign;
		}

		public function get vAlign():String {
			return this._vAlign;
		}

		public function get scaleX():Number {
			return this._scaleX;
		}

		public function get scaleY():Number {
			return this._scaleY;
		}

		public function get volume():Number {
			return this._volume;
		}

		public function get repeat():int {
			return this._repeat;
		}

		public function get x():Number {
			return this._x;
		}

		public function get y():Number {
			return this._y;
		}

		public function get z():Number {
			return this._z;
		}

		public function get alpha():Number {
			return this._alpha;
		}

		public function get width():Number {
			return this._width;
		}

		public function get height():Number {
			return this._height;
		}

		public function get crop():Boolean {
			return this._crop;
		}
		// --
		
		public function get binding():DisplayObject {
			return this._binding;
		}
		
		nsarmored function set parent(value:View):void {
			this._parent = value;
		}
		
		public function get parent():View {
			return this._parent;
		}
		
		public function get preload():Boolean {
			return this._preload;
		}
		
		public function get noCache():Boolean {
			return this._noCache;
		}

		public function get ownContext():Boolean {
			return this._ownContext;
		}

		public function get runInBackground():Boolean {
			return this._runInBackground;
		}
		
		public function get bytes():uint {
			return this._bytes;
		}
		
		public function get type():String {
			return this._type;
		}
		
		public function get url():String {
			return this._url;
		}
		
		public function get id():String {
			return this._id;
		}
		
		public function get xml():XML {
			return this._xml;
		}
		
		public function dispose(flush:Boolean = false):void {
			this._binding = null;
			this._parent = null;
			this._xml = null;
			this._id = null;
		}
		
		public function toString():String {
			return '[File ' + this._id + ']';
		}
	}
}
// BinaryDataLoader (nada público)
// CSSLoader (nada público)
// DataLoader (nada público)
// LoaderMax
/*
public static function parse(data:*, vars:Object=null, childrenVars:Object=null):*
public function append(loader:LoaderCore):LoaderCore
public function prepend(loader:LoaderCore):LoaderCore
public function insert(loader:LoaderCore, index:uint=999999999):LoaderCore
public function remove(loader:LoaderCore):void
public function empty(disposeChildren:Boolean=true, unloadAllContent:Boolean=false):void
public function getChildrenByStatus(status:int, includeNested:Boolean=false):Array
public function getChildren(includeNested:Boolean=false, omitLoaderMaxes:Boolean=false):Array
public function prependURLs(prependText:String, includeNested:Boolean=false):void
public function replaceURLText(fromText:String, toText:String, includeNested:Boolean=false):void
public function getLoader(nameOrURL:String):*
public function getContent(nameOrURL:String):*
public function getChildIndex(loader:LoaderCore):uint
override public function auditSize():void
public static function activate(loaderClasses:Array):void
public static function registerFileType(extensions:String, loaderClass:Class):void
public static function getLoader(nameOrURL:String):*
public static function getContent(nameOrURL:String):*
public static function prioritize(nameOrURL:String, loadNow:Boolean=true):LoaderCore
public function get numChildren():uint
override public function get content():*
override public function get status():int
override public function get auditedSize():Boolean
public function get rawProgress():Number
*/
// LoaderStatus
/*
public static const READY:int = 0;
public static const LOADING:int = 1;
public static const COMPLETED:int = 2;
public static const PAUSED:int = 3;
public static const FAILED:int = 4;
public static const DISPOSED:int = 5;
*/
// MP3Loader
/*
public function playSound(event:Event=null):SoundChannel
public function pauseSound(event:Event=null):void
public function gotoSoundTime(time:Number, forcePlay:Boolean=false, resetRepeatCount:Boolean=true):void
override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
public function get soundPaused():Boolean
public function set soundPaused(value:Boolean):void
public function get playProgress():Number
public function set playProgress(value:Number):void
public function get volume():Number
public function set volume(value:Number):void
public function get soundTime():Number
public function set soundTime(value:Number):void
public function get duration():Number
*/
// SelfLoader (nada público)
// XMLLoader
/*
public function getLoader(nameOrURL:String):*
public function getContent(nameOrURL:String):*
public function getChildren(includeNested:Boolean=false, omitLoaderMaxes:Boolean=false):Array
public static function parseLoaders(xml:XML, all:LoaderMax, toLoad:LoaderMax=null):void
override public function get progress():Number
*/
// VideoLoader
/*
public function setContentDisplay(contentDisplay:Sprite):void
override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
public function addASCuePoint(time:Number, name:String="", parameters:Object=null):Object
public function removeASCuePoint(timeNameOrCuePoint:*):Object
public function getCuePointTime(name:String):Number
public function gotoVideoCuePoint(name:String, forcePlay:Boolean=false, skipCuePoints:Boolean=true):Number
public function pauseVideo(event:Event=null):void
public function playVideo(event:Event=null):void
public function gotoVideoTime(time:Number, forcePlay:Boolean=false, skipCuePoints:Boolean=true):Number
public function clearVideo():void
override public function auditSize():void
override public function get content():*
public function get rawContent():Video
public function get netStream():NetStream
public function get videoPaused():Boolean
public function set videoPaused(value:Boolean):void
public function get bufferProgress():Number
public function get playProgress():Number
public function set playProgress(value:Number):void
public function get volume():Number
public function set volume(value:Number):void
public function get videoTime():Number
public function set videoTime(value:Number):void
public function get duration():Number
public function get bufferMode():Boolean
public function set bufferMode(value:Boolean):void
public function get autoDetachNetStream():Boolean
public function set autoDetachNetStream(value:Boolean):void
public function get stageVideo():Object
public function set stageVideo(value:Object):void
*/
// SWFLoader
/*
public function getClass(className:String):Class
public function getSWFChild(name:String):DisplayObject
public function getLoader(nameOrURL:String):*
public function getContent(nameOrURL:String):*
public function getChildren(includeNested:Boolean=false, omitLoaderMaxes:Boolean=false):Array
public function set url(value:String):void
*/
// ImageLoader (nada público)
// DisplayObjectLoader
/*
public function setContentDisplay(contentDisplay:Sprite):void
override public function auditSize():void
override public function get content():*
public function get rawContent():*
*/
// LoaderItem
/*
override public function auditSize():void
public function get url():String
public function set url(value:String):void
public function get request():URLRequest
public function get httpStatus():int
public function get scriptAccessDenied():Boolean
*/
// LoaderCore
/*
public function load(flushContent:Boolean=false):void
public function pause():void
public function resume():void
public function cancel():void
public function unload():void
public function dispose(flushContent:Boolean=false):void
public function prioritize(loadNow:Boolean=true):void
override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
public function get paused():Boolean
public function set paused(value:Boolean):void
public function get status():int
public function get bytesLoaded():uint
public function get bytesTotal():uint
public function get progress():Number
public function get rootLoader():LoaderMax
public function get content():*
public function get auditedSize():Boolean
public function get loadTime():Number
*/