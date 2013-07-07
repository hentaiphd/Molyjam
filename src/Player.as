package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        [Embed(source = '../assets/girl_sprite.png')] public static var sprite:Class;

        private var runSpeed:Number = 1;
        public var snackGrabbed:FlxSprite = null;
        public var _scale:FlxPoint = new FlxPoint(1,1);
        public var _scaleFlipX:Number = 1;
        public var _scaleFlipY:Number = 1;

        public function Player(x:Number, y:Number):void{
            super(x,y);

            loadGraphic(sprite, true, true, 15, 28, true);
            width = 8;
            height = 8;
            offset.y = 21;

            addAnimation("run", [1,2], 14, true);
            addAnimation("standing", [0]);
            addAnimation("runBack", [4,5], 14, true);
            addAnimation("standingBack", [3]);

            this.scale = _scale;
        }

        public function isGrabbing(snack:Snacks = null):void{
            if(snackGrabbed == null){
                snackGrabbed = snack;
            }

            if(snackGrabbed != null){
                snackGrabbed.x = this.x+5;
                snackGrabbed.y = this.y;
            }
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.LEFT) {
                x -= runSpeed;
                this.scale.x = _scaleFlipX;
                this.scale.y = _scaleFlipY;
                play("run");
            } else if(FlxG.keys.RIGHT){
                x += runSpeed;
                this.scale.x = -_scaleFlipX;
                this.scale.y = _scaleFlipY;
                play("run");
            } else if(FlxG.keys.UP){
                y -= runSpeed;
                play("runBack");
            } else if(FlxG.keys.DOWN){
                y += runSpeed;
                play("run");
            } else if(FlxG.keys.justPressed("UP")){
                play("standingBack");
            } else if (FlxG.keys.justPressed("DOWN")){
                play("standing");
            } else {
                play("standing");
            }
        }
    }
}

