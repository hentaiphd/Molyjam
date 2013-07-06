package{
    import org.flixel.*;

    public class Snacks extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;

        public function Snacks(x:int, y:int):void{
            super(x,y);

            this.makeGraphic(2,2,0xFF00FF00)
        }

        override public function update():void{
            super.update();
        }
    }
}
