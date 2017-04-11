package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class StrangeItem extends MovieClip {
		public var ItemStr:String;
		public var ItemIndex:int=-1;
		public var ItemTextField:TextField;
		
		private var oldX:Number;
		private var newX:Number;
		
		
		
		public function StrangeItem(str:String,index:int) {
			ItemStr=str;
			ItemIndex=index;
			ItemTextField.text=str;
			
			this.btDelete.visible=false;
			
			this.BackBoard.gotoAndStop(1);
			addEventListener(MouseEvent.MOUSE_DOWN,onMSDown);
			addEventListener(MouseEvent.MOUSE_UP,onMSUp);
			addEventListener(MouseEvent.MOUSE_MOVE,onMSMove);
		}
		
		private function onMSDown(e:MouseEvent){
			this.BackBoard.gotoAndStop(2);
			oldX=e.localX
		}
		
		private function onMSMove(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
		}
		
		private function onMSUp(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
		}
	}
	
}
