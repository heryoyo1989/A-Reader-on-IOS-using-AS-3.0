package
{
	/*这个类可以奖标记和注释两种功能分开使用或者整合到一起，即画完直线后添加小旗输入注释*/
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.controls.*;
	import flash.text.TextField;
	import flash.display.Shape;

	public class Note extends MovieClip
	{

		public var hScrollBar: UIScrollBar;
		public var noteField: TextField;
		public var flag: MovieClip;
		public var lineLength: Number;
		public var butEnter: Button;
		public var mShape: Shape;
		public var IsAdded: Boolean = false;
		public var NoteIndex:int=-1;//在每一章中的索引

		public function Note()
		{
			
		}

		protected function showNote(e: MouseEvent)
		{
			IsAdded = !IsAdded;
			if (IsAdded == true)
			{
				
			}
			if (IsAdded == false)
			{
			
			}

		}
		protected function closeNote(e: MouseEvent)
		{
			if (IsAdded == true)
			{
				
			}
		}
	
	}

}