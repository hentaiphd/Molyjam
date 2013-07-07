package{
    import org.flixel.*;

    public class Snacks extends FlxSprite{
        [Embed(source = '../assets/candy1.png')] public static var sprite1:Class;
        [Embed(source = '../assets/candy2.png')] public static var sprite2:Class;
        [Embed(source = '../assets/candy3.png')] public static var sprite3:Class;
        [Embed(source = '../assets/candy4.png')] public static var sprite4:Class;
        [Embed(source = '../assets/candy1.png')] public static var sprite5:Class;
        [Embed(source = '../assets/lolli.png')] public static var sprite6:Class;
        [Embed(source = '../assets/lolli2.png')] public static var sprite7:Class;
        [Embed(source = '../assets/lolli3.png')] public static var sprite8:Class;
        [Embed(source = '../assets/chips.png')] public static var sprite9:Class;
        [Embed(source = '../assets/cookie.png')] public static var sprite10:Class;

        private static var foodGrp:FlxGroup;
        public var wasMoved:Boolean;

        public function Snacks(x:int, y:int):void{
            super(x,y);

            var pick:Number = FlxG.random()*10;
            var graphic:Class;
            if(pick > 9){
                graphic = sprite10;
            } else if(pick > 8){
                graphic = sprite9;
            } else if(pick > 7){
                graphic = sprite8;
            } else if(pick > 6){
                graphic = sprite7;
            } else if(pick > 5){
                graphic = sprite6;
            } else if(pick > 4){
                graphic = sprite5;
            } else if(pick > 3){
                graphic = sprite4;
            } else if(pick > 2){
                graphic = sprite3;
            } else if(pick > 1){
                graphic = sprite2;
            } else {
                graphic = sprite1;
            }

            var _scale:FlxPoint = new FlxPoint(.5,.5);

            loadGraphic(graphic);
            this.scale = _scale;
        }

        override public function update():void{
            super.update();
        }
    }
}
