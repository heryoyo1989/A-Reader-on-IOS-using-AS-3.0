package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	
	public class SearchItem extends MovieClip {
		public var ItemStr:String;
		public var ItemIndex:int=-1;
		public var ItemTextField:TextField;
		public var FirstY:Number;
		public var NewY:Number;
		public var OldY:Number;
		
		public function SearchItem(str:String,index:int) {
			// constructor code
			ItemStr=str;
			ItemIndex=index;
			ItemTextField.text=str;
			this.BackBoard.gotoAndStop(1);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onDown)
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMove)
			this.addEventListener(MouseEvent.MOUSE_UP,onUp)
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut)
		}
		
		private function onDown(e:MouseEvent){
			this.BackBoard.gotoAndStop(2);
			FirstY=NewY=OldY=e.stageY;
		}
		
		private function onMove(e:MouseEvent){
			if(e.buttonDown==true){
				NewY=e.stageY;
				if(NewY-FirstY>20||NewY-FirstY<-20){
				     this.BackBoard.gotoAndStop(1);
				}
			}
		}
		
		private function onUp(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
		}
		private function onOut(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
		}
	}
	
}
