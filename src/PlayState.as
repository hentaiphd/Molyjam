package{
    import org.flixel.*;
    import org.flixel.system.FlxTile;

    public class PlayState extends FlxState {
        [Embed(source="../assets/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] private var Map:Class;
        [Embed(source="../assets/tiles1.png")] private var ImgTiles:Class;
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

            _level = new FlxTilemap();
            _level.loadMap(new Map,ImgTiles,8,8,FlxTilemap.OFF);
            _level.follow();
            add(_level);

            _level.setTileProperties(1,0,null,null,10);
            _level.setTileProperties(15,0);
            _level.setTileProperties(44,0,null,null,3);

            _player = new Player(170,100);
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
