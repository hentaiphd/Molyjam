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
            t.text = "Move using your arrow keys: left, right, up and down.\n\nHold Z to pick up and carry snacks to hide in your stash. (Hint: it's blinking!)\n\nDon't let mom catch you with snacks... or your stash! To distract her, knock stuff over with Z.";
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
