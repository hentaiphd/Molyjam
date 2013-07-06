package
{
    import org.flixel.*;

    public class MenuState extends FlxState
    {
        override public function create():void
        {
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,"molyjamz");
            t.size = 16;
            t.alignment = "center";
            add(t);
            t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"x to play");
            t.alignment = "center";
            add(t);

            FlxG.mouse.hide();
        }

        override public function update():void
        {
            super.update();

            if(FlxG.keys.X)
            {
                FlxG.switchState(new PlayState());
            }
        }
    }
}
