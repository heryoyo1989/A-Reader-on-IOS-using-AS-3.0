package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	
	public class ContentItem extends MovieClip {
		
		public var ItemStr:String;
		public var ItemIndex:int=-1;
		public var ItemTextField:TextField;
		
		private var oldX:Number;
		private var newX:Number;
		
		public function ContentItem(str:String,index:int) {
			ItemStr=str;
			ItemIndex=index;
			ItemTextField.text=str;
			this.BackBoard.gotoAndStop(1);
			//以下几个的主要目地就是按下有一个阴影效果
			addEventListener(MouseEvent.MOUSE_DOWN,onMSDown);
			//addEventListener(MouseEvent.MOUSE_UP,onMSUp);
			addEventListener(MouseEvent.MOUSE_MOVE,onMSMove);
		}
		
		private function onMSDown(e:MouseEvent){
			this.BackBoard.gotoAndStop(2);
			oldX=e.localX
		}
		
		private function onMSMove(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
			/*if(e.buttonDown==true){
				newX=e.localX;
				
				
				this.BackBoard.x+=(newX-oldX);
				if(this.BackBoard.x<=-120)this.BackBoard.x=-120;
			    if(this.BackBoard.x>=0)this.BackBoard.x=0;
				
				this.ItemTextField.x+=(newX-oldX);
				if(this.ItemTextField.x<=-100)this.ItemTextField.x=-100;
			    if(this.ItemTextField.x>=20)this.ItemTextField.x=20;
				
				oldX=newX;
			}*/
		}
		
		private function onMSUp(e:MouseEvent){
			this.BackBoard.gotoAndStop(1);
			/*newX=e.localX;
			this.BackBoard.x+=(newX-oldX);
			if(this.BackBoard.x<=-60)this.BackBoard.x=-120;
			if(this.BackBoard.x>-60)this.BackBoard.x=0;
			
			this.ItemTextField.x+=(newX-oldX);
			if(this.ItemTextField.x<=-40)this.ItemTextField.x=-100;
			if(this.ItemTextField.x>-40)this.ItemTextField.x=20;*/
		}
		
		
	}
	
}
