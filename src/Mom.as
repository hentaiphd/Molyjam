package{
    import org.flixel.*;

    public class Mom extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;
        private var xAnchor:int;
        private var yAnchor:int;
        private var textLock:Boolean = false;
        private var _curTarget:FlxPoint;
        private var _hasHitTarget:Boolean;
        private var _level:FlxTilemap;

        public var _reply:FlxText;

        public function Mom(x:Number, y:Number, _level:FlxTilemap):void{
            super(x,y);

            xAnchor = x;
            yAnchor = y;
            this._level = _level;

            this.makeGraphic(20,15,0xFFFFFFFF)
        }

        override public function update():void{
            super.update();
        }

        public function setTarget(_point:FlxPoint):void{
            this._curTarget = _point;
            if(_point.x == x && _point.y == y){
                this._hasHitTarget = true;
                return;
            }
            var path:FlxPath = this._level.findPath(
                new FlxPoint(x + width/2, y + height/2), _point);
            this.followPath(path);
        }

        public function moveToPoint(_point:FlxPoint, _level:FlxTilemap):void{
            var path:FlxPath = _level.findPath(new FlxPoint(x + width/2, y + height/2), _point);
            this.followPath(path);
        }
    }
}
