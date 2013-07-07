package{
    import flash.utils.ByteArray;

    import org.flixel.*;
    import org.flixel.system.FlxTile;

    public class PlayState extends FlxState {
        [Embed(source="../assets/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] private var Map:Class;
        [Embed(source="../assets/tiles1.png")] private var ImgTiles:Class;
        protected var _level:FlxTilemap;
        protected var _player:Player;
        protected var zoomcam:ZoomCamera;
        protected var _momGrp:FlxGroup;
        protected var _snackGrp:FlxGroup;
        protected var _noiseGrp:FlxGroup;
        protected var _text:FlxText;
        protected var _timer:Number;

        protected var _endgameActive:Boolean;
        protected var _gameStateActive:Boolean;
        protected var _pregameActive:Boolean = true;

        protected var _goalSprite:FlxSprite;

        protected var _unusedSnackPositions:Array;
        protected var _unusedMomPositions:Array;
        protected var _unusedNoisePositions:Array;
        protected var _unusedEndzones:Array;

        protected var _coordsText:FlxText;

        public function assert(expression:Boolean):void{
            if (!expression)
                throw new Error("Assertion failed!");
        }

        override public function create():void{
            setupItemPositions();

            FlxG.mouse.show();

            _timer = 0;

            _level = new FlxTilemap();
            _level.loadMap(new Map,ImgTiles,8,8,FlxTilemap.OFF);
            _level.follow();
            add(_level);

            _level.setTileProperties(1,0,null,null,10);
            _level.setTileProperties(15,0);
            _level.setTileProperties(44,0,null,null,4);

            for(var j:Number = 0; j < 1; j++){
                var thisIndex:Number = Math.floor(Math.random()*_unusedEndzones.length);
                var _rect:FlxRect = _unusedEndzones[thisIndex] as FlxRect;
                _goalSprite = new FlxSprite(_rect.x, _rect.y);
                _goalSprite.makeGraphic(_rect.width, _rect.height, 0x44FF0000);
                add(_goalSprite);
                _unusedEndzones.splice(thisIndex, 1);
            }

            _player = new Player(10, 10);
            add(_player);

            FlxG.worldBounds = new FlxRect(0, 0, _level.width, _level.height);

            zoomcam = new ZoomCamera(0, 0, 640, 480);
            FlxG.resetCameras(zoomcam);
            zoomcam.target = _level;
            zoomcam.targetZoom = 1;

            _momGrp = new FlxGroup();
            for(var i:Number = 0; i < 3; i++){
                thisIndex = Math.floor(Math.random()*_unusedMomPositions.length);
                var mypos:FlxPoint = _unusedMomPositions[thisIndex] as FlxPoint;
                var _mom:Mom = new Mom(mypos.x, mypos.y,_level);
                _momGrp.add(_mom);
                add(_mom);
                _unusedMomPositions.splice(thisIndex, 1);
            }

            _snackGrp = new FlxGroup();
            for(i = 0; i < 8; i++){
                thisIndex = Math.floor(Math.random()*_unusedSnackPositions.length);
                mypos = _unusedSnackPositions[thisIndex] as FlxPoint;
                var _snack:Snacks = new Snacks(mypos.x, mypos.y);
                add(_snack);
                _snackGrp.add(_snack);
                _unusedSnackPositions.splice(thisIndex, 1);
            }

            _noiseGrp = new FlxGroup();
            for(i = 0; i < 3; i++){
                thisIndex = Math.floor(Math.random()*_unusedNoisePositions.length);
                mypos = _unusedNoisePositions[thisIndex] as FlxPoint;
                var _noise:NoiseZone = new NoiseZone(mypos.x, mypos.y);
                add(_noise);
                _noiseGrp.add(_noise);
                _unusedNoisePositions.splice(thisIndex, 1);
            }

            _coordsText = new FlxText(0, FlxG.height/2, 640, "0 x 0");
            _coordsText.alignment = "center";
            _coordsText.color = 0xFFFF0000;
            _coordsText.scrollFactor = new FlxPoint(0, 0);
            //add(_coordsText);
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

        public function flipGoalSpriteColor():void{
            if(_goalSprite.alpha == 0){
                _goalSprite.alpha = .4;
            } else {
                _goalSprite.alpha = 0;
            }
        }

        public function startGame():void{
            _gameStateActive = true;
            zoomcam.target = _player;
            zoomcam.targetZoom = 3;
        }

        override public function update():void{
            _timer += FlxG.elapsed;
            _coordsText.text = FlxG.mouse.screenX + " x " + FlxG.mouse.screenY;

            if(_endgameActive){
                if(FlxG.keys.X){
                    FlxG.resetState();
                }
            } else if(_pregameActive){
                if(_timer > 5 && !_gameStateActive){
                    _pregameActive = false;
                    startGame();
                }
            } else if(_gameStateActive){
                super.update();
                FlxG.collide(_player, _level);

                updateMomAI();

                _player.isGrabbing();

                if(FlxG.keys.Z){
                    if(_player.snackGrabbed == null){
                        for(var i:Number = 0; i < _snackGrp.length; i++){
                            if(displacement(_player, _snackGrp.members[i]) < 15){
                                _player.isGrabbing(_snackGrp.members[i]);
                            }
                        }
                        for(i = 0; i < _noiseGrp.length; i++){
                            if(displacement(_player, _noiseGrp.members[i]) < 15){
                                _noiseGrp.members[i].makeActive();
                            }
                        }
                    }
                } else {
                    _player.snackGrabbed = null;
                }
            }

            if(Math.floor(_timer) % 2 == 0){
                flipGoalSpriteColor();
            }

        }

        public function updateMomAI():void{
            for(var i:Number = 0; i < _momGrp.length; i++){
                var _tmom:Mom = _momGrp.members[i];
                _tmom.searchFor(_player, _timer);
                if((_player.snackGrabbed &&
                    _tmom.isInRange(new FlxPoint(_player.x, _player.y))) ||
                    (_tmom.overlaps(_goalSprite) && goalContainsSnack())){
                    if((_tmom.overlaps(_goalSprite) && goalContainsSnack())){
                        FlxG.camera.target = _tmom;
                    }
                    if(!_endgameActive){
                        _endgameActive = true;
                        showEndgame();
                    }
                }
                for(var j:Number = 0; j < _noiseGrp.length; j++){
                    if(_noiseGrp.members[j].isActivated &&
                    _momGrp.members[i].displacement(_noiseGrp.members[j]) < 700){
                        _momGrp.members[i]._distracted = true;
                        _momGrp.members[i].setTarget(
                            new FlxPoint(_noiseGrp.members[j].x, _noiseGrp.members[j].y));
                    }
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

        public function setupItemPositions():void{
            _unusedSnackPositions = new Array(
                new FlxPoint(274, 329),
                new FlxPoint(189, 360),
                new FlxPoint(196, 310),
                new FlxPoint(204, 360),
                new FlxPoint(54, 360),
                new FlxPoint(269, 216),
                new FlxPoint(277, 135),
                new FlxPoint(54, 126),
                new FlxPoint(30, 213),
                new FlxPoint(70, 215),
                new FlxPoint(134, 189),
                new FlxPoint(205, 188),
                new FlxPoint(207, 269),
                new FlxPoint(133, 271),
                new FlxPoint(367, 7),
                new FlxPoint(367, 87),
                new FlxPoint(214, 81),
                new FlxPoint(227, 12),
                new FlxPoint(305, 8)
            );

            _unusedMomPositions = new Array(
                new FlxPoint(196, 17),
                new FlxPoint(107, 143),
                new FlxPoint(161, 345),
                new FlxPoint(299, 277),
                new FlxPoint(315, 29),
                new FlxPoint(167, 122),
                new FlxPoint(193, 223),
                new FlxPoint(387, 223)
            );

            _unusedNoisePositions = new Array(
                new FlxPoint(227, 219),
                new FlxPoint(260, 307),
                new FlxPoint(356, 102),
                new FlxPoint(314, 43),
                new FlxPoint(173, 11),
                new FlxPoint(23, 59),
                new FlxPoint(124, 135),
                new FlxPoint(15, 166),
                new FlxPoint(39, 227),
                new FlxPoint(162, 360),
                new FlxPoint(55, 360)
            );

            _unusedEndzones = new Array();
            var _spr:FlxRect = new FlxRect(320, 320, 30, 30);
            _unusedEndzones.push(_spr);
            _spr = new FlxRect(320, 97, 40, 80);
            _unusedEndzones.push(_spr);
            _spr = new FlxRect(3, 267, 90, 50);
            _unusedEndzones.push(_spr);
            _spr = new FlxRect(3, 3, 115, 75);
            _unusedEndzones.push(_spr);
            _spr = new FlxRect(3, 327, 90, 60);
            _unusedEndzones.push(_spr);
            _spr = new FlxRect(272, 169, 40, 10);
            _unusedEndzones.push(_spr);
        }

        public function displacement(_object1:FlxSprite, _object2:FlxSprite):Number{
            var dx:Number = Math.abs(_object1.x - _object2.x);
            var dy:Number = Math.abs(_object1.y - _object2.y);
            return Math.sqrt(dx*dx + dy*dy);
        }
    }
}
