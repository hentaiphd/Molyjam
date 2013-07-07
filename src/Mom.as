package{
    import org.flixel.*;

    public class Mom extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;
        private var xAnchor:int;
        private var yAnchor:int;
        private var textLock:Boolean = false;
        private var _curTarget:FlxPoint;
        private var _level:FlxTilemap;
        private var _lastFoundTime:Number = 0;
        private var _runSpeed:Number;

        public var _hasHitTarget:Boolean;
        public var _reply:FlxText;

        public function Mom(x:Number, y:Number, _level:FlxTilemap):void{
            super(x,y);

            this._level = _level;
            this._runSpeed = Math.random() * (50-40) + 40;


            this.makeGraphic(5,5,0xFFFF0000)
        }

        override public function update():void{
            super.update();

            if(_curTarget && this.isInRange(this._curTarget)){
                stopFollowing();
            }
        }

        public function searchFor(_object:FlxSprite, _time:Number):void{
            var found:Boolean = _level.ray(new FlxPoint(x, y),
                                           new FlxPoint(_object.x, _object.y));
            if(found){
                _lastFoundTime = _time;
            }
            var maxDisp:Number = 100;
            if((_time - _lastFoundTime < .5) ||
             found && displacement(_object) < maxDisp){
                setTarget(new FlxPoint(_object.x, _object.y));
            }
        }

        public function displacement(_object:FlxSprite):Number{
            var dx:Number = Math.abs(_object.x - this.x);
            var dy:Number = Math.abs(_object.y - this.y);
            return Math.sqrt(dx*dx + dy*dy);
        }

        public function isInRange(_point:FlxPoint):Boolean{
            if(Math.abs(_point.x - this.x) < 10 &&
               Math.abs(_point.y - this.y) < 10){
                return true;
            }
            return false;
        }

        public function stopFollowing():void{
            this.stopFollowingPath(true);
            this.velocity.x = this.velocity.y = 0;
            this._curTarget = null;
        }

        public function setTarget(_point:FlxPoint):void{
            this._curTarget = _point;

            var path:FlxPath = this._level.findPath(
                new FlxPoint(x + width/2, y + height/2), _point);
            if(path){
                this.followPath(path, _runSpeed);
            }
        }

        public function moveToPoint(_point:FlxPoint, _level:FlxTilemap):void{
            var path:FlxPath = _level.findPath(new FlxPoint(x + width/2, y + height/2), _point);
            this.followPath(path);
        }
    }
}
