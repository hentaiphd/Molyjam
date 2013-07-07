package{
    import org.flixel.*;

    public class NoiseZone extends FlxSprite{
        [Embed(source = '../assets/lamp.png')] public static var sprite1:Class;
        [Embed(source = '../assets/books.png')] public static var sprite2:Class;
        [Embed(source = '../assets/trash.png')] public static var sprite3:Class;
        [Embed(source = '../assets/vase.png')] public static var sprite4:Class;
        public var isActivated:Boolean = false;
        private var _timer:Number = 0;
        private var _activatedTime:Number = 0;

        public function NoiseZone(x:int, y:int):void{
            super(x,y);

            var pick:Number = FlxG.random()*4;
            var graphic:Class;
            if(pick > 3){
                graphic = sprite4;
                loadGraphic(sprite4, true, true, 18, 14, true); //vase
                addAnimation("fall", [1]);
                addAnimation("stand", [0]);
            } else if(pick > 2){
                graphic = sprite3;
                loadGraphic(sprite3, true, true, 17, 20, true); //trash
                addAnimation("fall", [1]);
                addAnimation("stand", [0]);
            } else if(pick > 1){
                graphic = sprite2;
                loadGraphic(sprite2, true, true, 21, 17, true); //book
                addAnimation("fall", [1]);
                addAnimation("stand", [0]);
            } else {
                graphic = sprite1;
                loadGraphic(sprite1, true, true, 22, 23, true); //lamp
                addAnimation("fall", [1]);
                addAnimation("stand", [0]);
            }

            play("stand");

        }

        public function makeActive():void{
            if(!isActivated){
                isActivated = true;
                _activatedTime = _timer;
                play("fall");
            }
        }

        override public function update():void{
            super.update();
            _timer += FlxG.elapsed;

            if(isActivated && _timer - _activatedTime > 2){
                isActivated = false;
                play("stand");
            }
        }
    }
}
