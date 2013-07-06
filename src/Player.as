package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;

        public function Player(x:int, y:int):void{
            super(x,y);

            this.makeGraphic(20,20,0x4E0B1FFF)

            drag.x = 10;
            drag.y = 10;
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.LEFT) {
                acceleration.x -= drag.x;
            } else if(FlxG.keys.RIGHT){
                acceleration.x += drag.x;
            } else if(FlxG.keys.UP){
                acceleration.y -= drag.y;
            } else if(FlxG.keys.DOWN){
                acceleration.y +=drag.y;
            }
        }
    }
}

