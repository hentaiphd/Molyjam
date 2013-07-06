package{
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
    protected var _snack2:Snacks;
    protected var _snack3:Snacks;
    protected var _snack4:Snacks;

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

            _snack = new Snacks(250,100);
            add(_snack);
            _snackGrp.add(_snack);

            _snack2 = new Snacks(100,250);
            add(_snack2);
            _snackGrp.add(_snack2);

            _snack3 = new Snacks(100,100);
            add(_snack3);
            _snackGrp.add(_snack3);

            _snack3 = new Snacks(300,300);
            add(_snack3);
            _snackGrp.add(_snack3);
        }

        public function collisionCallback(player:Player, mom:Mom):void{
            _mom.stopFollowing();
        }

        override public function update():void{
            super.update();
            FlxG.collide(_player, _level);

            if(FlxG.keys.X){
                _mom.setTarget(new FlxPoint(_player.x, _player.y));
            }

            //move currently grabbed object to position of player
            _player.isGrabbing();

            if(FlxG.keys.SPACE){
                if(_player.snackGrabbed == null){
                    for(var i:Number = 0; i < _snackGrp.length; i++){
                        if(_player.overlaps(_snackGrp.members[i])){
                            _player.grabbed = true;
                            _player.isGrabbing(_snackGrp.members[i]);
                        }
                    }
                }
            } else {
                _player.snackGrabbed = null;
            }
        }
    }
}
