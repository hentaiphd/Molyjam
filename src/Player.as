package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;

        private var runSpeed:Number = 3;
        public var snackGrabbed:FlxSprite = null;

        public function Player(x:Number, y:Number):void{
            super(x,y);

            this.makeGraphic(5,5,0xFF0B1FFF)
        }

        public function isGrabbing(snack:Snacks = null):void{
            if(snackGrabbed == null){
                snackGrabbed = snack;
            }

            if(snackGrabbed != null){
                snackGrabbed.x = this.x+20;
                snackGrabbed.y = this.y;
            }
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.LEFT) {
                x -= runSpeed;
            } else if(FlxG.keys.RIGHT){
                x += runSpeed;
            }
            if(FlxG.keys.UP){
                y -= runSpeed;
            } else if(FlxG.keys.DOWN){
                y += runSpeed;
            }
        }
    }
}

