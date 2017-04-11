package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Link extends MovieClip {
		public var number:int=-1;//以便于删除的时候，先不用添加，删除的时候还要重新编排号码
		public var Index:int;
		public var Name:String;
		public var Type:String;
		
		public function Link(index:int,nam:String,typ:String) {
			Index=index;
			Name=nam;
			Type=typ;
			//关于可以识别的类型，这里还有FileReference里也要体现
			if(Type=="jpg"||Type=="gif"||Type=="png"){
				this.gotoAndStop(1);
			}
			if(Type=="mp3"||Type=="wma"){
				this.gotoAndStop(2);
			}
			if(Type=="swf"){
				this.gotoAndStop(3);
			}
			if(Type=="txt"){
				this.gotoAndStop(4);
			}
			this.addEventListener(MouseEvent.CLICK,getLink)
		}
		
		private function getLink(e:MouseEvent){
			trace("name is "+Name);
			trace("type is "+Type);
			var tempBoard:ShowLinkBoard=new ShowLinkBoard(Name,Type);
			tempBoard.x=stage.stageWidth/2-tempBoard.width/2;
			tempBoard.y=stage.stageHeight/2-tempBoard.height/2;
			stage.addChild(tempBoard);
			//这里要新建一个类用以显示链接中的各种素材
			//这个板要有删除功能，但在正常阅读的程序中没有删除功能
		}
	}
	
}
