package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;

        private var runSpeed = 5;

        public function Player(x:int, y:int):void{
            super(x,y);

            this.makeGraphic(20,20,0x4E0B1FFF)
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

