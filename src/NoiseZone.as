package{
    import org.flixel.*;

    public class NoiseZone extends FlxSprite{
        //[Embed(source = '../assets/sprite.jpg')] public static var sprite:Class;
        public var isActivated:Boolean = false;
        private var _timer:Number = 0;
        private var _activatedTime:Number = 0;

        public function NoiseZone(x:int, y:int):void{
            super(x,y);

            this.makeGraphic(5,5,0xFFFFFF00)
        }

        public function makeActive():void{
            isActivated = true;
            _activatedTime = _timer;
        }

        override public function update():void{
            super.update();
            _timer += FlxG.elapsed;
            if(isActivated && _timer - _activatedTime > 2){
                isActivated = false;
            }
        }
    }
}
