package{
    import org.flixel.*;

    public class MenuState extends FlxState{
        [Embed(source="../assets/start.png")] private var ImgBG:Class;
        [Embed(source = "../assets/bgm_mom.mp3")] private var bgm:Class;

        override public function create():void{
            var bg:FlxSprite = new FlxSprite(0, 0, ImgBG);
            add(bg);

            var t2:FlxText;
            t2 = new FlxText(0,FlxG.height-40,FlxG.width,"Z to play // UP to instructions");
            t2.alignment = "center";
            t2.color = 0xff2d686b;
            t2.size = 16;
            add(t2);

            t2 = new FlxText(0,FlxG.height-120,FlxG.width,"Nina Freeman and Emmett Butler\nMusic by seagaia\nMolyjam 2013");
            t2.alignment = "center";
            t2.color = 0xff2d686b;
            t2.size = 16;
            add(t2);

            FlxG.mouse.hide();

            FlxG.playMusic(bgm);
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.Z){
                FlxG.switchState(new PlayState());
            } else if(FlxG.keys.UP){
                FlxG.switchState(new HowState());
            }
        }
    }
}
