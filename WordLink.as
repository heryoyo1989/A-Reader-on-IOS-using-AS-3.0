package  {
	
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	
	
	public class WordLink extends MovieClip {
		
		public var TextWidth:Number;
		public var TextHeight:Number;
		public var myTextFormat:TextFormat=new TextFormat();
		public var myStr:String;
		public var index1:int;
		public var index2:int;
		public var typ:String;
		public var url:String;
		
		public function WordLink(wid:Number,hei:Number,str:String,tf:TextFormat,in1:int,in2:int,ty:String,ur:String) {

			/*myTextFormat.font="黑体"
			myTextFormat.size=20;
			myTextFormat.color=0x0000ff;
			myTextFormat.underline=true;*/
			
			TextWidth=wid;
			TextHeight=hei;
			myStr=str;
			
			index1=in1;
			index2=in2;
			typ=ty;
			url=ur;
			
			if(typ=="txt"){
				tf.color=0xff0000;
			}
			
			if(typ=="mp3"){
				tf.color=0x00ff00;
			}
			
			if(typ=="jpg"||typ=="png"){
				tf.color=0x0000ff;
			}
			
			if(typ=="swf"||typ=="flv"){
				tf.color=0xff00ff;
			}
			
			myTextField.width=TextWidth;
			myTextField.height=TextHeight;
			myTextField.defaultTextFormat=tf;
			myTextField.text=myStr;
			
			this.addEventListener(MouseEvent.CLICK, getUrl);
		}
		
		private function getUrl(e:MouseEvent){
			var tempBoard:ShowLinkBoard=new ShowLinkBoard(url,typ);
			tempBoard.x=stage.stageWidth/2-tempBoard.width/2;
			tempBoard.y=stage.stageHeight/2-tempBoard.height/2;
			stage.addChild(tempBoard);
		}
	}
	
}
