package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;

        private var runSpeed:Number = 5;
        public var grabbed:Boolean = false;
        public var snackGrabbed:FlxSprite = null;

        public function Player(x:Number, y:Number):void{
            super(x,y);

            this.makeGraphic(20,20,0x4E0B1FFF)
        }

        public function isGrabbing(snack:Snacks = null):void{
            if(snackGrabbed == null){
                snackGrabbed = snack;
            }

            if(snackGrabbed != null){
                snackGrabbed.x = this.x+40;
                snackGrabbed.y = this.y;
            }
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.LEFT) {
                x -= runSpeed;
            } else if(FlxG.keys.RIGHT){
                x += runSpeed;
            } else if(FlxG.keys.UP){
                y -= runSpeed;
            } else if(FlxG.keys.DOWN){
                y += runSpeed;
            }
        }
    }
}

