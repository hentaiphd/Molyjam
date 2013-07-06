package{
    import org.flixel.*;

    public class Mom extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;
        private var xAnchor:int;
        private var yAnchor:int;
        public var _reply:FlxText;
        private var textLock:Boolean = false;

        public function Mom(x:int, y:int):void{
            super(x,y);

            xAnchor = x;
            yAnchor = y;

            this.makeGraphic(20,15,0xFFFFFFFF)

        }

        override public function update():void{
            super.update();

        }
    }
}