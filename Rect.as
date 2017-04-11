package 
{
	import flash.display.MovieClip;
	import flash.display.Shape;

	public class Rect extends MovieClip
	{
		public var wid:Number;
		public var hei:Number;
		public var MyShape:Shape;

		public function Rect(kuan:Number,gao:Number)
		{
			wid=kuan;
			hei=gao;
			MyShape=new Shape();
			MyShape.graphics.beginFill(0xff0000,0.4);
			MyShape.graphics.drawRect(0,0,kuan,gao);
			addChild(MyShape);
		}
	}

}