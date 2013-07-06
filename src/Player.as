package{
    import org.flixel.*;

    public class Player extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;

        private var runSpeed:uint = 10;

        public function Player(x:int, y:int):void{
            super(x,y);

            this.makeGraphic(20,20,0x4E0B1FFF)

            drag.x = runSpeed*80;
            drag.y = runSpeed*80;
        }

        override public function update():void{
            super.update();

            acceleration.x = 0;
            acceleration.y = 400;

            if(FlxG.keys.LEFT) {
                acceleration.x -= drag.x;
            } else if(FlxG.keys.RIGHT){
                acceleration.x += drag.x;
            }
        }
    }
}

