package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	
	
	public class SoundLinkBoard extends MovieClip {
		public var url:String;
		public var startPos:int;
		public var endPos:int;
		private var soundTimer:Timer=new Timer(50);
		public var sound:Sound;
		public var scChannel:SoundChannel;
		
		private var newSPX:Number;
		private var oldSPX:Number;
		
		private var IsDown:Boolean=false;
		
		private var IsStopped:Boolean=true;
		
		private var Postion:Number;
		
		public function SoundLinkBoard(ur:String,sp:int,ep:int) {
			url=ur;
			startPos=sp;
			endPos=ep;
			getSound(url);
			
			this.btQuit.addEventListener(MouseEvent.CLICK, quitBoard)
			
			this.dragBoard.addEventListener(MouseEvent.MOUSE_DOWN,onDrag)
			
			this.dragBoard.addEventListener(MouseEvent.MOUSE_UP,offDrag)
			
			//this.btSC.addEventListener(MouseEvent.CLICK,onBtSC)
			
			//this.btSC.gotoAndStop(1);
			
			this.btStop.addEventListener(MouseEvent.CLICK,onBtStop)
			
			this.btContinue.addEventListener(MouseEvent.CLICK,onBtContinue)
			
			this.btContinue.visible=false;
			
			this.IsStopped=false;
		}
		
		public function getSound(soundURL:String){
			var soundRequest:URLRequest=new URLRequest(soundURL);
	        sound=new Sound();
		    scChannel=new SoundChannel();
		   
	        sound.load(soundRequest);
	        sound.addEventListener(Event.COMPLETE, loadCompleted)
			
			SoundProgresser.addEventListener(MouseEvent.MOUSE_DOWN,onSPDown)
			SoundProgresser.addEventListener(MouseEvent.MOUSE_MOVE,onSPMove)
			SoundProgresser.addEventListener(MouseEvent.MOUSE_UP,onSPUp)
			
		}
		
		private function loadCompleted(e:Event){
			var totalPos:int=sound.length;
			trace(totalPos);
			scChannel = sound.play(startPos);//里面加位置
			
			//this.btSC.gotoAndStop(1);
			
			this.IsStopped=false;
			
		    soundTimer.start();
			soundTimer.addEventListener(TimerEvent.TIMER,trackSoundHandler);
		}
		
		private function onSPDown(e:MouseEvent){
			oldSPX=e.stageX;
			this.IsDown=true;
		}
		
		private function onSPMove(e:MouseEvent){
			if(e.buttonDown==true&&e.localY>-50&&e.localY<0){
				this.IsDown=false;
				newSPX=e.stageX;
			    SoundProgresser.moveRect.x+=(newSPX-oldSPX);
			   if(SoundProgresser.moveRect.x>=500)SoundProgresser.moveRect.x=500;
			   if(SoundProgresser.moveRect.x<=0)SoundProgresser.moveRect.x=0;
			   oldSPX=newSPX;
				
			   scChannel.stop();
		       scChannel = sound.play(startPos+SoundProgresser.moveRect.x*(endPos-startPos)/500);
			   soundTimer.start();
			}
		}
		
		private function onSPUp(e:MouseEvent){
			if(this.IsDown==true){
			   SoundProgresser.moveRect.x=e.localX;
			   scChannel.stop();
			   scChannel = sound.play(startPos+SoundProgresser.moveRect.x*(endPos-startPos)/500);
			   soundTimer.start();
			}

		}
		
		 private function trackSoundHandler(e:TimerEvent){
			var tempPos:int=scChannel.position;
			 
			this.Postion=scChannel.position;
			 
			 TimeField.text=changeTime(scChannel.position-this.startPos)+"/"+changeTime(this.endPos-this.startPos)
			 trace();
			
			SoundProgresser.moveRect.x=(tempPos-startPos)*500/(endPos-startPos);
			
			if(tempPos>=endPos){
				soundTimer.stop();
				scChannel.stop();
				trace("sound is stopped");
			}
		}
		
		 private function onDrag(e:MouseEvent){
			this.startDrag();
		}
		
		private function offDrag(e:MouseEvent){
			this.stopDrag();
		}

		private function quitBoard(e: MouseEvent)
		{
			scChannel.stop();
			
			soundTimer.stop();
			
			stage.removeChild(this);
		}
		
		private function onBtSC(e:MouseEvent){
			if(IsStopped==true){
					this.soundTimer.start();
				    scChannel=sound.play(this.Postion);
					//this.btSC.gotoAndStop(1);
					IsStopped=false;
			}else if(IsStopped==false){
				    this.Postion=scChannel.position;
				    this.soundTimer.stop();
				    scChannel.stop();
					//this.btSC.gotoAndStop(2);
				    IsStopped=true;
			}
		}
		
		private function onBtStop(e:MouseEvent){
			this.soundTimer.stop();
			scChannel.stop();
			btStop.visible=false;
			btContinue.visible=true;
		}
		
		private function onBtContinue(e:MouseEvent){
			this.soundTimer.start();
			scChannel=sound.play(this.Postion);
			btStop.visible=true;
			btContinue.visible=false;
		}
		private function changeTime(num:Number):String{
			num=num/1000;
			var minute:Number;
			var second:Number;
			second=num%60;
			minute=(num-second)/60;
			var outPut:String=minute+":"+second.toFixed(0);
			if(second<10)outPut=minute+":0"+second.toFixed(0);
			return(outPut);
		}
	}
	
}
