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

        override public function create():void{

            _level = new FlxTilemap();
            _level.loadMap(FlxTilemap.imageToCSV(ImgMap,false,4),ImgTiles,0,0,FlxTilemap.ALT);
            _level.follow();
            add(_level);

            _player = new Player(120,100);
            add(_player);

            FlxG.worldBounds = new FlxRect(0, 0, _level.width, _level.height);

            var cam:ZoomCamera = new ZoomCamera(0, 0, 640, 480);
            FlxG.resetCameras(cam);
            cam.target = _player;
            cam.targetZoom = 2;

            _mom = new Mom(400,270,_level);
            add(_mom);

            _snackGrp = new FlxGroup();

            _snack = new Snacks(250,100);
            add(_snack);
            _snackGrp.add(_snack);

            _snack = new Snacks(100,250);
            add(_snack);
            _snackGrp.add(_snack);

            _snack = new Snacks(100,100);
            add(_snack);
            _snackGrp.add(_snack);

            _snack = new Snacks(300,300);
            add(_snack);
            _snackGrp.add(_snack);
        }

        public function collisionCallback(player:Player, mom:Mom):void{
            _mom.stopFollowing();
        }

        override public function update():void{
            super.update();

            FlxG.collide(_player, _level);

            var tgt:FlxPoint = _mom.searchFor(_player);
            if(tgt){
                _mom.setTarget(tgt);
            }

            _player.isGrabbing();

            if(FlxG.keys.Z){
                if(_player.snackGrabbed == null){
                    for(var i:Number = 0; i < _snackGrp.length; i++){
                        if(_player.overlaps(_snackGrp.members[i])){
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
