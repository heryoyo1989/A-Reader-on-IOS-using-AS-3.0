package
{
	import flash.display.MovieClip;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.display.Shape;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;


	public class ShowLinkBoard extends MovieClip
	{
		public var LinkNumber: int = -1; //用于删除，如果需要的话
		public var LinkName: String;
		public var LinkType: String;
		//public var btQuit: Button;

		public var Field: TextField;
		public var loader: Loader;
		public var sound:Sound;
		public var scChannel:SoundChannel;
		public var rectangle:Shape;
		private var txtLoader:URLLoader;
        public var SoundProgresser:MovieClip;
		
		public var dragBoard:MovieClip;

		private var url: String;
		private var req: URLRequest;
		
		private var soundTimer:Timer=new Timer(50);
		
		private var newSPX:Number;
		private var oldSPX:Number;
		
		private var IsDown:Boolean=false;
		
		private var IsStopped:Boolean=false;
		
		private var Postion:Number;
		
		private var myVideo:Video=new Video();
		
		private var stream:NetStream;

		public function ShowLinkBoard(nam: String, typ: String)
		{
			LinkName = nam;
			LinkType = typ;

			url = nam; 
			req = new URLRequest(url);

			loader = new Loader();
			loader.x = 0;
			loader.y = 0;
			
			rectangle=new Shape();
			rectangle.graphics.beginFill(0xff0000);
			rectangle.graphics.lineStyle(0,0x000000);
			rectangle.graphics.drawRect(0,0,450,330);
			rectangle.graphics.endFill();
			
			this.btStop.visible=false;
			
			this.btContinue.visible=false;

			if (LinkType == "txt")
			{
				showTxt();
			}
			if (LinkType == "jpg" || LinkType == "png")
			{
				showPicture();
			}
			if (LinkType == "mp3")
			{
				showSound();
			}
			if (LinkType == "swf")
			{
				showSwf();
			}
			if(LinkType == "flv")
			{
				showFlv();
			}
			this.btQuit.addEventListener(MouseEvent.CLICK, quitBoard)
			
			this.dragBoard.addEventListener(MouseEvent.MOUSE_DOWN,onDrag)
			
			this.dragBoard.addEventListener(MouseEvent.MOUSE_UP,offDrag)
			
			soundTimer.addEventListener(TimerEvent.TIMER,trackSoundHandler)
			
			
		}
		
	    private function onDrag(e:MouseEvent){
			this.startDrag();
		}
		
		private function offDrag(e:MouseEvent){
			this.stopDrag();
		}

		private function quitBoard(e: MouseEvent)
		{
			if(LinkType == "swf"||LinkType == "jpg"||LinkType == "png"){
				loader.unloadAndStop();
			    this.LoaderBoard.removeChild(loader);
			}
			if(LinkType=="mp3"){
				scChannel.stop();
			}
			
			if(LinkType=="txt"){
				this.Field.text="";
				soundTimer.stop();
			}
			if(LinkType=="flv"){
				//removeChild(myVideo);
				myVideo=new Video();
				stream.close();
			}
			
			stage.removeChild(this);
		}

		private function showLoader()
		{
			LoaderBoard.visible = true;
			Field.visible = false;
			SoundProgresser.visible = false;
			TimeField.visible=false;
			//btSC.visible=false;
		}

		private function showTF()
		{
			LoaderBoard.visible = false;
			Field.visible = true;
			SoundProgresser.visible = false;
			TimeField.visible=false;
			//btSC.visible=false;
		}
		
		private function showSP()
		{
			LoaderBoard.visible = false;
			Field.visible = false;
			SoundProgresser.visible = true;
			TimeField.visible=true;
			//btSC.visible=true;
			//btSC.buttonMode=true;
			btQuit.x=370;
			//btSC.text1.buttonMode=true;
			//btSC.text2.buttonMode=true;
			//btSC.gotoAndStop(1);
			
			IsStopped=false;
			SoundProgresser.addEventListener(MouseEvent.MOUSE_DOWN,onSPDown)
			SoundProgresser.addEventListener(MouseEvent.MOUSE_MOVE,onSPMove)
			SoundProgresser.addEventListener(MouseEvent.MOUSE_UP,onSPUp)
			
			//btSC.addEventListener(MouseEvent.CLICK,onBtSC);
			
            this.btStop.addEventListener(MouseEvent.CLICK,onBtStop)
			
			this.btContinue.addEventListener(MouseEvent.CLICK,onBtContinue)
			
			this.btStop.visible=true;
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
		private function onSPDown(e:MouseEvent){
			oldSPX=e.localX;
			this.IsDown=true;
			//SoundProgresser.moveRect.x=e.localX;
		}
		
		private function onSPMove(e:MouseEvent){
			if(e.buttonDown==true&&e.localY>140&&e.localY<200){
				this.IsDown=false
				newSPX=e.localX;
			    SoundProgresser.moveRect.x+=(newSPX-oldSPX);
			   if(SoundProgresser.moveRect.x>=500)SoundProgresser.moveRect.x=500;
			   if(SoundProgresser.moveRect.x<=0)SoundProgresser.moveRect.x=0;
			   oldSPX=newSPX;
				
			   scChannel.stop();
		       scChannel = sound.play(SoundProgresser.moveRect.x*sound.length/500);
			   soundTimer.start();
			}
		}
		
		private function onSPUp(e:MouseEvent){
			   if(this.IsDown==true){
				   SoundProgresser.moveRect.x=e.localX;
			       scChannel.stop();
		           scChannel = sound.play(SoundProgresser.moveRect.x*sound.length/500);
			       soundTimer.start();
			   }
		}
		
		private function showPicture()
		{
			showLoader();
			loader.load(req); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete)
			this.LoaderBoard.addChild(loader);
			this.LoaderBoard.addChild(rectangle);
			loader.mask=rectangle;
		}

		private function showSound()
		{
			showSP();

			var soundURL:String=LinkName;
 
	       var soundRequest:URLRequest=new URLRequest(soundURL);
	       sound=new Sound();
		   scChannel=new SoundChannel();
		   
	       sound.load(soundRequest);
	       sound.addEventListener(Event.COMPLETE, loadCompleted)
		   soundTimer.start();
	
	       function loadCompleted(e:Event){
		      scChannel=sound.play();
	       }
		}
		
        private function trackSoundHandler(e:TimerEvent){
			var tempPos:int=scChannel.position/1000;
			var totalPos:int=sound.length/1000;
			
			TimeField.text=changeTime(scChannel.position)+"/"+changeTime(sound.length)

			SoundProgresser.moveRect.x=tempPos*500/totalPos;
			if(tempPos==totalPos){
				soundTimer.stop();
				trace("sound is stopped");
			}
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
		
		private function showSwf()
		{
			showLoader();
			loader.load(req); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete)
			this.LoaderBoard.addChild(loader);
			this.LoaderBoard.addChild(rectangle);
			loader.mask=rectangle;
		}
				
		private function showFlv(){
			Field.visible = false;
			SoundProgresser.visible = false;
			TimeField.visible=false;
			//btSC.visible=false;
			
			var connection:NetConnection=new NetConnection();
			connection.connect(null);
		    stream=new NetStream(connection);
			myVideo.attachNetStream(stream);

			var client:Object=new Object();
			client.onMetaData=onMetaData;
			stream.client=client;
			
			stream.play(url);
			
			function onMetaData(){
			   myVideo.x=40;
			   myVideo.y=50;
			   myVideo.width=550//info.width;
			   myVideo.height=300//info.height;
			   addChild(myVideo);
		   }
		}

		private function showTxt()
		{
			showTF();
	        txtLoader=new URLLoader();
			txtLoader.load(req);
			txtLoader.addEventListener(Event.COMPLETE,getTxt)
		}
		
		private function getTxt(e:Event){
			this.Field.text=txtLoader.data;
		}

		private function onComplete(e:Event){
           displayLoader();
		}

		private function displayLoader()
		{
			var LIWidth: Number = 450; 
			var LIHeight: Number = 330;
			
			//var LIWidth:Number=loader.loaderInfo.width;
	        //var LIHeight:Number=loader.loaderInfo.height;

			var CTWidth: Number = loader.content.width;
			var CTHeight: Number = loader.content.height;

			var CLIWidth: Number = loader.contentLoaderInfo.width;
			var CLIHeight: Number = loader.contentLoaderInfo.height;

			trace("inwid "+CLIWidth+"   kjdl  "+loader.contentLoaderInfo)
			
			loader.content.width = CTWidth * LIWidth / CLIWidth;
			loader.content.height = CTHeight * LIHeight / CLIHeight;
			
			//loader.content.width=LIWidth;
			//loader.content.height=LIHeight;
		}

	}

}