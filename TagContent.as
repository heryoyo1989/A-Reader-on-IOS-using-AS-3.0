package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	
	public class TagContent extends MovieClip {
		
		public var ItemStr:String;
		public var ItemIndex:int=-1;
		public var ItemTextField:TextField;
		
		private var oldX:Number;
		private var newX:Number;
		
		public var canMove:Boolean=true;
		
		public function TagContent(str:String,index:int) {
			// constructor code
			ItemStr=str;
			ItemIndex=index;
			ItemTextField.text=str;
			this.BackBoard.gotoAndStop(1);
			
			hideButton();
			
			//以下几个的主要目地就是按下有一个阴影效果
			//addEventListener(MouseEvent.MOUSE_DOWN,onMSDown);
			//addEventListener(MouseEvent.MOUSE_UP,onMSUp);
			//addEventListener(MouseEvent.MOUSE_MOVE,onMSMove);
			//this.BackBoard.addEventListener(MouseEvent.CLICK,onMSClick);
			//this.ItemTextField.addEventListener(MouseEvent.CLICK,onMSClick);
		}
		
		public function hideButton(){
			this.btGo.visible=false;
			this.btDelete.visible=false;
		}
		
		public function showButton(){
			this.btGo.visible=true;
			this.btDelete.visible=true;
		}
	
	
		private function onMSDown(e:MouseEvent){
			this.BackBoard.gotoAndStop(2);
			oldX=e.localX;
			if(e.localX<500){
				for(var i:int=0;i<this.parent.numChildren;i++){
				    if(this.parent.getChildAt(i) is TagContent){
					   TagContent(this.parent.getChildAt(i)).hideButton();
				    }
			    }
			}
			
			
		}
		
		private function onMSMove(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
			if(e.buttonDown==true&&canMove==true){
				newX=e.localX;
				oldX=newX;
			}
		}
		
		private function onMSUp(e:MouseEvent){
			if(canMove==true){
			this.BackBoard.gotoAndStop(1);
			newX=e.localX;
			}
		}
				
	}
	
}
