package{
    import org.flixel.*;
    import org.flixel.system.FlxTile;

    public class PlayState extends FlxState {
        [Embed(source="../assets/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] private var Map:Class;
        [Embed(source="../assets/tiles1.png")] private var ImgTiles:Class;
        protected var _level:FlxTilemap;
        protected var _player:Player;
        protected var _momGrp:FlxGroup;
        protected var _snackGrp:FlxGroup;
        protected var _noiseGrp:FlxGroup;
        protected var _text:FlxText;
        protected var _timer:Number;
        protected var _endgameActive:Boolean;
        protected var _gameStateActive:Boolean = true;
        protected var _goalSprite:FlxSprite;

        protected var _coordsText:FlxText;

        override public function create():void{
            FlxG.mouse.show();

            _timer = 0;

            _level = new FlxTilemap();
            _level.loadMap(new Map,ImgTiles,8,8,FlxTilemap.OFF);
            _level.follow();
            add(_level);

            _level.setTileProperties(1,0,null,null,10);
            _level.setTileProperties(15,0);
            _level.setTileProperties(44,0,null,null,4);

            _goalSprite = new FlxSprite(320, 320);
            _goalSprite.makeGraphic(30, 30, 0x00FF00FF);
            add(_goalSprite);

            _player = new Player(300,300);
            add(_player);

            FlxG.worldBounds = new FlxRect(0, 0, _level.width, _level.height);

            var cam:ZoomCamera = new ZoomCamera(0, 0, 640, 480);
            FlxG.resetCameras(cam);
            cam.follow(_level);
            cam.target = _player;
            cam.targetZoom = 1.5;

            _momGrp = new FlxGroup();
            for(var i:Number = 0; i < 4; i++){
                var _mom:Mom = new Mom(Math.random()*(300-100)+100,Math.random()*(300-100)+100,_level);
                _momGrp.add(_mom);
                add(_mom);
            }

            _snackGrp = new FlxGroup();
            for(i = 0; i < 20; i++){
                var _snack:Snacks = new Snacks(Math.random()*(300),Math.random()*(300));
                add(_snack);
                _snackGrp.add(_snack);
            }

            _noiseGrp = new FlxGroup();
            for(i = 0; i < 5; i++){
                var _noise:NoiseZone = new NoiseZone(Math.random()*(300),Math.random()*(300));
                add(_noise);
                _noiseGrp.add(_noise);
            }

            _coordsText = new FlxText(0, FlxG.height/2, 640, "0 x 0");
            _coordsText.alignment = "center";
            _coordsText.color = 0xFFFF0000;
            _coordsText.scrollFactor = new FlxPoint(0, 0);
            add(_coordsText);
        }

        public function goalContainsSnack():Boolean{
            for(var i:Number = 0; i < _snackGrp.length; i++){
                var _snk:Snacks = _snackGrp.members[i];
                if(_snk.overlaps(_goalSprite)){
                    return true;
                }
            }
            return false;
        }

        override public function update():void{
            _timer += FlxG.elapsed;
            _coordsText.text = FlxG.mouse.screenX + " x " + FlxG.mouse.screenY;

            if(_endgameActive){
                if(FlxG.keys.X){
                    FlxG.resetState();
                }
            } else if(_gameStateActive){
                super.update();
                FlxG.collide(_player, _level);

                for(var i:Number = 0; i < _momGrp.length; i++){
                    var _tmom:Mom = _momGrp.members[i];
                    _tmom.searchFor(_player, _timer);
                    if((_player.snackGrabbed &&
                     _tmom.isInRange(new FlxPoint(_player.x, _player.y))) ||
                     (_tmom.overlaps(_goalSprite) && goalContainsSnack)){
                        if(!_endgameActive){
                            _endgameActive = true;
                            showEndgame();
                        }
                    }
                    for(var j:Number = 0; j < _noiseGrp.length; j++){
                        if(_noiseGrp.members[j].isActivated &&
                        _momGrp.members[i].displacement(_noiseGrp.members[j]) < 200){
                            _momGrp.members[i]._distracted = true;
                            _momGrp.members[i].setTarget(
                                new FlxPoint(_noiseGrp.members[j].x, _noiseGrp.members[j].y));
                        }
                    }
                }

                _player.isGrabbing();

                if(FlxG.keys.Z){
                    if(_player.snackGrabbed == null){
                        for(i = 0; i < _snackGrp.length; i++){
                            if(_player.overlaps(_snackGrp.members[i])){
                                _player.isGrabbing(_snackGrp.members[i]);
                            }
                        }
                        for(i = 0; i < _noiseGrp.length; i++){
                            if(_player.overlaps(_noiseGrp.members[i])){
                                _noiseGrp.members[i].makeActive();
                            }
                        }
                    }
                } else {
                    _player.snackGrabbed = null;
                }
            }
        }

        public function showEndgame():void{
            var op:FlxSprite = new FlxSprite(0, 0);
            op.makeGraphic(640, 480);
            op.fill(0x55000000);
            add(op);

            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-50,FlxG.width,"caught!!");
            t.size = 18;
            t.scrollFactor = new FlxPoint(0, 0);
            t.alignment = "center";
            add(t);
            t = new FlxText(0,FlxG.height/2+40,FlxG.width,"X to retry");
            t.alignment = "center";
            t.size = 10;
            t.scrollFactor = new FlxPoint(0, 0);
            add(t);
        }
    }
}
