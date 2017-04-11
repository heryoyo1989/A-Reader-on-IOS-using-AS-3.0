package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	
	
	public class SoundLink extends MovieClip {
		public var index:int;
		public var url:String;
		public var startPos:int;
		public var endPos:int;
		private var soundTimer:Timer=new Timer(50);
		public var sound:Sound;
		public var scChannel:SoundChannel;
		
		public function SoundLink(ind:int,ur:String,sp:int,ep:int) {
			// constructor code
			index=ind;
			url=ur;
			startPos=sp;
			endPos=ep;
			
			soundTimer.addEventListener(TimerEvent.TIMER,trackSoundHandler)

			this.addEventListener(MouseEvent.CLICK,readIt);
			
			
		}
		
		private function readIt(e:MouseEvent){
			var tempBoard:SoundLinkBoard=new SoundLinkBoard(url,startPos,endPos);
			tempBoard.x=stage.stageWidth/2;
			tempBoard.y=stage.stageHeight/2;
			stage.addChild(tempBoard);
			
			//getSound("hl2.mp3");
		}
		
		public function getSound(soundURL:String){
			var soundRequest:URLRequest=new URLRequest(soundURL);
	        sound=new Sound();
		    scChannel=new SoundChannel();
		   
	        sound.load(soundRequest);
	        sound.addEventListener(Event.COMPLETE, loadCompleted)
		}
		
		private function loadCompleted(e:Event){
			var totalPos:int=sound.length;
			trace(totalPos);
			scChannel = sound.play(startPos);//里面加位置
		    soundTimer.start();
		}
		
		 private function trackSoundHandler(e:TimerEvent){
			var tempPos:int=scChannel.position;
			var totalPos:int=sound.length;
			
			if(tempPos>=endPos){
				soundTimer.stop();
				scChannel.stop();
				trace("sound is stopped");
			}
		}
		
	}
	
}
