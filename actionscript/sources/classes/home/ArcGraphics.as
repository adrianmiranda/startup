package home {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ArcGraphics extends Sprite {
        protected var canvas:Sprite;
        protected var gCanvas:Sprite;
        protected var tCanvas:Sprite;
        private var textout:TextField;
        private var shapeList:Array;
        private var pathList:Array;
        private var lineList:Array;
        private var dragTarget:Sprite = null;
        private var handleList:Array;
        private var left:Number, right:Number, top:Number, bottom:Number;
        
        protected const C_MOVABLE:uint = 0xFF6600;
        protected const C_DRAGGABLE:uint = 0x0066FF;
        protected const C_FIXED:uint = 0x000000;
        protected const C_GUIDE:uint = 0xAAAAAA;
        
        public function ArcGraphics():void {
            pathList = new Array();
            lineList = new Array();
            shapeList = new Array();
            handleList = new Array();
            
            addChild(gCanvas = new Sprite());
            gCanvas.graphics.lineStyle(0, C_GUIDE, 0.5);
            addChild(canvas = new Sprite());
            addChild(tCanvas = new Sprite());
            addChild(textout = getTextout());
            addEventListener(Event.ENTER_FRAME,h_enterFrame0);
            addEventListener(Event.ENTER_FRAME,h_enterFrame1);
            addEventListener(Event.ENTER_FRAME,h_enterFrame2);
            origin(0, 0);
        }

        protected function h_enterFrame0(evt:Event):void {
            updateDrag();
        }
        
        protected function h_enterFrame1(evt:Event):void {
            step();
        }
        
        protected function step():void {
            // to override
        }
        
        private function h_enterFrame2(evt:Event):void {
            updateGraphics();
        }
        
        private function updateDrag():void {
          if (!dragTarget) { return }
          
          var item:Object;
          var i:uint;
          
          dragTarget.x = canvas.mouseX;
          dragTarget.y = canvas.mouseY;
          
          for (i = 0; i < handleList.length; i ++) {
            item = handleList[i];
            item.obj.x = item.sprite.x;
            item.obj.y = item.sprite.y;
          }
        }
            
        private function updateGraphics():void {
          var g:Graphics = canvas.graphics;
          var item:Object;
          var i:uint;
          
          for (i = 0; i < shapeList.length; i ++) {
            item = shapeList[i];
            item.sprite.x = item.obj.x;
            item.sprite.y = item.obj.y;
          }
          
          g.clear();
          for (i = 0; i < pathList.length; i ++) {
            item = pathList[i];
            g.lineStyle(item.w, item.col, 0.5);
            g.moveTo(item.obj1.x, item.obj1.y);
            g.lineTo(item.obj2.x, item.obj2.y);
          }

          for (i = 0; i < lineList.length; i ++) {
            item = lineList[i];
            
            var l:Pp2dLine = Pp2dLine.fromPoints(item.obj1.x, item.obj1.y, item.obj2.x, item.obj2.y);
            g.lineStyle(item.w, item.col, 0.5);
            
            if (l.slope == 0) {
              g.moveTo(left, item.obj1.y);
              g.lineTo(right, item.obj1.y);
            } else if (isNaN(l.slope)) {
              g.moveTo(item.obj1.x, top);
              g.lineTo(item.obj1.x, bottom);
            } else if (l.slope > 1 || l.slope < -1) {
              g.moveTo(l.yToX(top), top);
              g.lineTo(l.yToX(bottom), bottom);
            } else {
              g.moveTo(left, l.xToY(left));
              g.lineTo(right, l.xToY(right));
            }
          }
        }
        
        /**
         * origin
         */
        protected function origin(x,y):void {
            gCanvas.x = canvas.x = x;
            gCanvas.y = canvas.y = y;
            left = x - stage.stageWidth;
            right = stage.stageWidth - x;
            top = y - stage.stageHeight;
            bottom = stage.stageHeight - y;
        }
        
        /**
         * guide
         */
        protected function guide(x1:Number,y1:Number,x2:Number,y2:Number):void {
            var g:Graphics = gCanvas.graphics;
            g.moveTo(x1,y1);
            g.lineTo(x2,y2);
        }
        
        protected function guideLabel(x:Number,y:Number,str:String):void {
            var t:TextField = label(str, C_GUIDE);
            t.x = x;
            t.y = y;
            gCanvas.addChild(t);
        }
        
        /**
         * graphic items
         */
        protected function circle(obj:DynamicPoint, radius:Number = 3, col:uint = C_FIXED,labelStr:String = "") {
            var s:Sprite = new Sprite();
            s.graphics.beginFill(col, 0.5);
            s.graphics.drawCircle(0,0,radius);
            s.graphics.endFill();
            if (labelStr.length > 0) {
                var l:TextField = label(labelStr,col);
                s.addChild(l);
            }
            return addShape(obj, s);
        }
        
        private function addShape(obj:DynamicPoint,s:Sprite):Object {
            var item:Object = {obj:obj,sprite:s};
            s.x = obj.x;
            s.y = obj.y;
            canvas.addChild(s);
            shapeList.push(item);
            return item;
        }
        
        protected function path(obj1:DynamicPoint, obj2:DynamicPoint,col:uint = C_MOVABLE, w:Number = 0):Object {
            var item:Object = {obj1:obj1,obj2:obj2,col:col,w:w};
            pathList.push(item);
            return item;
        }

        protected function line(obj1:DynamicPoint, obj2:DynamicPoint,col:uint = C_MOVABLE, w:Number = 0):Object {
            var item:Object = {obj1:obj1,obj2:obj2,col:col,w:w};
            lineList.push(item);
            return item;
        }

        /**
         * text
         */
        private function label(str:String, col:uint):TextField {
            var t:TextField = new TextField();
            var tf:TextFormat = new TextFormat();
            t.autoSize = TextFieldAutoSize.LEFT;
            t.selectable = false;
            tf.font = "_sans";
            tf.color = col;
            t.defaultTextFormat = tf;
            t.text = str;
            return t;
        }
        
        private function getTextout():TextField {
            var t:TextField = new TextField();
            var tf:TextFormat = new TextFormat();
            t.width = stage.width - 20;
            t.height = stage.height - 20;
            t.x = t.y = 10;
            t.multiline = true;
            t.autoSize = TextFieldAutoSize.LEFT;
            t.selectable = false;
            tf.font = "_sans";
            tf.color = C_GUIDE;
            t.defaultTextFormat = tf;
            return t;
        }
        
        protected function print(str:String):void {
            textout.appendText(str + "\n");
        }

        protected function clearText():void {
            textout.text = "";
        }
        
        /**
         * drag
         */
        protected function enableDrag(...args):void {
            var s:Sprite;
            var item:Object;
            for (var i:uint = 0; i < args.length; i ++) {
                for (var j:uint = 0; j < shapeList.length; j ++) {
                    if (shapeList[j].obj == args[i]) { 
                        s = shapeList[j].sprite;
                        s.addEventListener(MouseEvent.MOUSE_DOWN, h_draggable_mouseDown);      
                        s.addEventListener(MouseEvent.MOUSE_UP, h_draggable_mouseUp);
                        s.useHandCursor = true;
                        s.buttonMode = true;
                        s.tabEnabled = false;
                        item = {obj:args[i],sprite:s};
                        handleList.push(item);
                    }
                }
            }
        }
        
        private function h_draggable_rollOver(evt:Event):void {
            evt.currentTarget.alpha = 0.5;
        }
        
        private function h_draggable_rollOut(evt:Event):void {
            evt.currentTarget.alpha = 1;
        }
        
        private function h_draggable_mouseDown(evt:Event):void {
            dragTarget = evt.currentTarget as Sprite;
        }
        
        private function h_draggable_mouseUp(evt:Event):void {
            dragTarget = null;
        }
        
        /**
         * util
         */
        protected function radToDeg(n:Number):Number {
            return n / Math.PI * 180;
        }

        protected function degToRad(n:Number):Number {
            return n * Math.PI / 180;
        }

        protected function rd(n:Number):Number {
            return Math.round(n * 100) / 100;
        }
    }
}