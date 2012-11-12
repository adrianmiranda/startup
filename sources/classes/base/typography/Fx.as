package base.typography
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flupie.textanim.TextAnimSequence;
	import flupie.textanim.TextAnim;
	import flupie.textanim.TextAnimAnchor;
	import flupie.textanim.TextAnimBlock;
	import flupie.textanim.TextAnimSplit;
	import flupie.textanim.TextAnimMode;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import flash.text.TextField;
	
	public final class Fx
	{
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > TO
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function to(textField:TextField, time:Number, params:Object):void
		{

		}

		private static function animateTo(block:TextAnimBlock):void
		{
			
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > FROM
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function from(textField:TextField, time:Number, params:Object):void
		{

		}

		private static function animateFrom(block:TextAnimBlock):void
		{
			
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > MULTILINE
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function multiline(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.blocksVisible = false;
			textAnim.split = TextAnimSplit.LINES;
			textAnim.interval = 50;
			textAnim.effects = Fx.multilineBlock;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function multilineBlock(block:TextAnimBlock):void
		{
			var finalY:Number = block.y;
			block.y += 160;
			TweenMax.to(block, 0.9, { y:finalY, ease:Back.easeOut });
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > MULTILINE 3D
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function multiline3D(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.mode = TextAnimMode.FIRST_LAST;
			textAnim.split = TextAnimSplit.WORDS;
			textAnim.anchorX = TextAnimAnchor.LEFT;
			textAnim.anchorY = TextAnimAnchor.TOP;
			textAnim.blocksVisible = false;
			textAnim.effects = Fx.multiline3DBlock;
			textAnim.interval = 60;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function multiline3DBlock(block:TextAnimBlock):void
		{
			var finalX:Number = block.x;
			var finalY:Number = block.y;
			block.scaleX = block.scaleY = 3;
			block.rotationY = 90;
			block.alpha = 0;
			block.y += 60;
			TweenMax.to(block, 1, { alpha:1, x:finalX, y:finalY, rotationY:0, scaleX:1, scaleY:1, ease:Quint.easeOut });
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > BASIC
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function basic(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.mode = TextAnimMode.CENTER_EDGES;
			textAnim.blocksVisible = false;
			textAnim.effects = Fx.basicBlock;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function basicBlock(block:TextAnimBlock):void
		{
			block.scaleX = block.scaleY = 0;
			TweenMax.to(block, 1, { scaleX:1, scaleY:1, ease:Elastic.easeOut });
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > LITLE
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function litle(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.mode = TextAnimMode.CENTER_EDGES;
			textAnim.effects = Fx.litleBlock;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function litleBlock(block:TextAnimBlock):void
		{
			block.alpha = 0;
			block.x = block.posX + 20;
			block.rotation = Math.random() * 180;
			TweenMax.to(block, 0.9, { x:block.posX, rotation:0, alpha:1, ease:Elastic.easeOut });
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > SCALE X
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function scaleX(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.blocksVisible = false;
			textAnim.effects = Fx.scaleXBlock;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function scaleXBlock(block:TextAnimBlock):void
		{
			block.scaleX = 0;
			TweenMax.to(block, 0.8, { scaleX:1, ease:Elastic.easeOut });
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > SCALE Y
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function scaleY(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.blocksVisible = false;
			textAnim.effects = Fx.scaleYBlock;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function scaleYBlock(block:TextAnimBlock):void
		{
			block.scaleY = 0;
			TweenMax.to(block, 0.8, { scaleY:1, ease:Elastic.easeOut });
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > HTML
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function html(textField:TextField, value:String, delay:Number = 0, html:Boolean = true):TextAnim
		{
			var textAnim:TextAnim = new TextAnim(textField);
			if (html) textAnim.htmlText = value;
			else textAnim.text = value;
			textAnim.mode = TextAnimMode.LAST_FIRST;
			textAnim.split = TextAnimSplit.WORDS;
			textAnim.blocksVisible = false;
			textAnim.effects = Fx.htmlBlock;
			textAnim.interval = 50;
			setTimeout(textAnim.start, Math.max(0, delay) * 1000);
			return textAnim;
		}
		
		private static function htmlBlock(block:TextAnimBlock):void
		{
			block.y = block.posY - 80;
			block.rotation = Math.random() * 90;
			block.alpha = 0;
			TweenMax.to(block, 0.5, { alpha:1, rotation:0, y:block.posY, ease:Back.easeOut });
		}
	}
}