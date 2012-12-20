package home {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.Point;

    public class Arc extends ArcGraphics {
        private var unitLength:Number = 100;
        private var P:DynamicPoint, C:DynamicPoint,A:DynamicPoint,O:DynamicPoint;

        public function Arc() {
            origin(stage.stageWidth / 2,stage.stageHeight / 2);
            
            guide(- stage.stageWidth / 2, 0, stage.stageWidth /2, 0);
            guide(0, - stage.stageHeight / 2, 0, stage.stageHeight /2);
            gCanvas.graphics.drawCircle(0,0,unitLength)
            guideLabel(150,0,"L");
            
            P = new DynamicPoint(100,100);
            C = new DynamicPoint(100,0);
            A = new DynamicPoint(100,100);
            O = new DynamicPoint(0,0);
            circle(P,8,C_DRAGGABLE, "P");
            circle(C,2,C_FIXED, "C");
            circle(A,2,C_FIXED, "A");
            circle(O,2,C_FIXED, "O");
            path(A,C, C_GUIDE);
            path(P,O, C_MOVABLE);
            
            enableDrag(P);
        }
        
        override protected function step():void {
            var OP:Number, AOC:Number;
            OP = Math.sqrt(P.x * P.x + P.y * P.y);
            A.x = P.x / OP * unitLength;
            A.y = P.y / OP * unitLength;      
            C.x = A.x;
            
            clearText();
            print("OP = " + rd(OP));
            AOC = Math.atan2(A.y,A.x);
            print("AOC(deg.) = " + rd(radToDeg(AOC)));
            print("sin(AOC) = " + rd(Math.sin(AOC)));
            print("cos(AOC) = " +rd( Math.cos(AOC)));
            if (C.x != 0) {
                print("tan(AOC) =  AC / OC= " +rd( Math.tan(AOC)));
            }
        }
    }
}