package{
    import org.flixel.*;

    public class Mom extends FlxSprite{
        [Embed(source = '../assets/mom_sprite.png')] public static var sprite:Class;
        private var xAnchor:int;
        private var yAnchor:int;
        private var textLock:Boolean = false;
        private var _curTarget:FlxPoint;
        private var _level:FlxTilemap;
        private var _lastFoundTime:Number = 0;
        private var _runSpeed:Number;
        private var originPoint:FlxPoint;

        public var _hasHitTarget:Boolean;
        public var _distracted:Boolean;
        public var _distractedTime:Number;
        public var _reply:FlxText;

        public var _timer:Number;

        public static var maxSpeed:Number = 80;
        public static var minSpeed:Number = 70;

        public var _scale:FlxPoint = new FlxPoint(1,1);
        public var _scaleFlipX:Number = 1;
        public var _scaleFlipY:Number = 1;

        public var lastFramVel:FlxPoint = new FlxPoint();

        public function Mom(x:Number, y:Number, _level:FlxTilemap):void{
            super(x,y);

            this._level = _level;
            this._runSpeed = Math.random() * (maxSpeed-minSpeed) + minSpeed;
            this.originPoint = new FlxPoint(x, y);

            loadGraphic(sprite, true, true, 15, 33, true);
            width = 8;
            height = 8;
            offset.y = 16;

            addAnimation("run", [1,2], 14, true);
            addAnimation("standing", [0]);
            addAnimation("runBack", [4,5], 14, true);
            addAnimation("standingBack", [3]);
        }

        override public function update():void{
            super.update();

            if(velocity.x > 0){
                //right
                play("run");
                this.scale.x = -_scaleFlipX;
                this.scale.y = _scaleFlipY;
            } else if(velocity.x < 0){
                //left
                play("run");
                this.scale.x = _scaleFlipX;
                this.scale.y = _scaleFlipY;
            } else if(velocity.y > 0){
                //down
                play("run");
            } else if(velocity.y < 0){
                //up
                play("runBack");
            } else if(velocity.x == 0){
                if(velocity.y == 0){
                    if(lastFramVel.y > 0){
                        play("standing");
                    } else {
                        play("standingBack");
                    }
                }
            }

            _timer += FlxG.elapsed;

            if(_curTarget && this.isInRange(this._curTarget)){
                stopFollowing();
            }

            lastFramVel = new FlxPoint(velocity.x, velocity.y);
        }

        public function searchFor(_object:Player, _time:Number):void{
            var found:Boolean = _level.ray(new FlxPoint(x, y),
                                           new FlxPoint(_object.x, _object.y));
            if(found){
                _lastFoundTime = _time;
            }
            var maxDisp:Number = 100;

            if(_object.snackGrabbed){
                if(((_time - _lastFoundTime < .5) ||
                 found && displacement(_object) < maxDisp)){
                    _distracted = false;
                    setTarget(new FlxPoint(_object.x, _object.y), 10);
                }
            }
            if(_time - _lastFoundTime > 5 && !_distracted) {
                setTarget(originPoint);
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
            this._distracted = false;
        }

        public function setTarget(_point:FlxPoint, speedup:Number = 0):void{
            this._curTarget = _point;

            var path:FlxPath = this._level.findPath(
                new FlxPoint(x + width/2, y + height/2), _point);
            if(path){
                this.followPath(path, _runSpeed+speedup);
            }
        }

        public function moveToPoint(_point:FlxPoint, _level:FlxTilemap):void{
            var path:FlxPath = _level.findPath(new FlxPoint(x + width/2, y + height/2), _point);
            this.followPath(path);
        }
    }
}
