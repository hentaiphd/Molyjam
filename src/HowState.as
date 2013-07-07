package
{
    import org.flixel.*;

    public class HowState extends FlxState{
        [Embed(source="../assets/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] private var Map:Class;
        [Embed(source="../assets/tiles1.png")] private var ImgTiles:Class;

        protected var _level:FlxTilemap;
        protected var _player:Player;

        override public function create():void{

            FlxG.bgColor = 0xFFccfbff;

            var t:FlxText = new FlxText(0,30,FlxG.width,"DOWN to play");
            t.alignment = "center";
            t.size = 22;

            t.color = 0xff2d686b;
            t.text = "LEFT, RIGHT, UP, DOWN Arrow Keys to move. \n\n Gather snacks by pressing and holding z. \n\n Hide them in your stash! (Hint: it's blinking!) \n\n Don't let mom catch you with snacks... or your stash! \n To distract her, knock stuff over with z.";
            add(t);

            t = new FlxText(0,FlxG.height-40,FlxG.width,"Z to play");
            t.alignment = "center";
            t.size = 20;
            t.color = 0xff2d686b;
            add(t);

            FlxG.mouse.hide();
        }

        override public function update():void{
            super.update();
            FlxG.collide(_player, _level);

            if(FlxG.keys.Z){
                FlxG.switchState(new PlayState());
            }
        }
    }
}
