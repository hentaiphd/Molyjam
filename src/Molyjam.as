package
{
    import org.flixel.*;
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]

    public class Molyjam extends FlxGame {

        public function Molyjam(){
            super(640,480,MenuState,1)
        }
    }
}