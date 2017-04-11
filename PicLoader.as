package  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.text.TextField;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	
	public class PicLoader extends MovieClip {
		
		public var myLoader:Loader=new Loader();
		public var LoaderWidth:Number;
		public var LoaderHeight:Number;
		public var myUrl:String;
		public var myTF:TextField=new TextField();
		public var myString:String;
		
		//public var PIC_COMPLETED:String="pic_completed";
		
		public function PicLoader(url:String, wid:Number, hei:Number) {
			// constructor code
			myUrl=url;
			LoaderWidth=wid;
			LoaderHeight=hei;
			myLoader.load(new URLRequest(url));
			addChild(myLoader);
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete)
		}
		private function onLoaderComplete(e:Event){
			var tempWidth:Number=myLoader.content.width;
			var tempHeight:Number=myLoader.content.height;
			//trace("width is  "+myLoader.content.width)
			//trace("height is  "+myLoader.content.height)
			myLoader.content.width=LoaderWidth;
			myLoader.content.height=LoaderHeight
			//LoaderWidth*tempHeight/tempWidth;
			//myLoader.content.width=100;
			//myLoader.content.height=400;
			
			//LoaderHeight=myLoader.content.height;
			
			//trace("yuyo is  "+LoaderHeight)
			//dispatchEvent(new Event(PIC_COMPLETED));
		}
	}
	
}
