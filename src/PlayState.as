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

            _player = new Player(120,100);
            add(_player);
            FlxG.camera.follow(_player, FlxCamera.STYLE_PLATFORMER);

            _mom = new Mom(100,170,_level);
            add(_mom);

            _snackGrp = new FlxGroup();

            _snack = new Snacks(50,250);
            add(_snack);
            _snackGrp.add(_snack);
        }

        public function collisionCallback(player:Player, mom:Mom):void{
            _mom.stopFollowing();
        }

        public function collisionCallbackSnack(player:Player, snack:Snacks):void{
            _text = new FlxText(_snack.x, _snack.y, 30, "Snacks!");
            _text.color = 0xffffffff;
        }

        override public function update():void{
            super.update();
            FlxG.collide(_player, _level);
            FlxG.collide(_player, _snack, collisionCallbackSnack)
            FlxG.collide(_player, _snack, collisionCallbackSnack)

            if(FlxG.keys.X){
                _mom.setTarget(new FlxPoint(_player.x, _player.y));
            }
        }
    }
}
