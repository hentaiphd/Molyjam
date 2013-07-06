package
{
    import org.flixel.*;
    import org.flixel.system.FlxTile;

    public class PlayState extends FlxState {
    [Embed(source="../assets/ImgMap.png")] private var ImgMap:Class;
    [Embed(source="../assets/tiles.png")] private var ImgTiles:Class;
    protected var _level:FlxTilemap;
    protected var _player:Player;
    protected var _mom:Mom;
    protected var _text:FlxText;
    protected var _snackGrp:FlxGroup;
    protected var _snack:Snacks;

        override public function create():void{

            //FlxG.bgColor = 0x00000000;

            _level = new FlxTilemap();
            _level.loadMap(FlxTilemap.imageToCSV(ImgMap,false,4),ImgTiles,0,0,FlxTilemap.ALT);
            _level.follow();
            add(_level);

            _player = new Player(100,100);
            add(_player);
            FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);

            _mom = new Mom(100,170);
            add(_mom);

            _snack = new Snacks(50,250);


        }

        public function collisionCallback(player:Player, mom:Mom):void{
        }

        public function collisionCallbackSnack(player:Player, snack:Snacks):void{
            _text = new FlxText(this.x, this.y, 30, "Snacks!");
        }

        override public function update():void{
            super.update();
            FlxG.collide(_player, _mom, collisionCallback);
            FlxG.collide(_player, _snack, collisionCallbackSnack)
            FlxG.collide();
        }
    }
}