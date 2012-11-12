package base.typography
{
	import com.ad.common.applyTextFormat;
	import com.ad.common.createTextField;
	import com.ad.common.cloneTextField;
	import com.ad.common.num;
	
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public final class Fonts
	{
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > REGISTER
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function registerFonts():void
		{
			try
			{
				Font.registerFont(BasicFont);
			}
			catch (error:Error)
			{
				trace('Fonts.registerFonts', error.message);
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > GET FORMAT
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function getBasicFont(size:uint = 10, color:uint = 0x0, bold:Boolean = false, italic:Boolean = false):TextFormat
		{
			return new TextFormat(new BasicFont().fontName, size, color, bold, italic);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > SET FORMAT
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function setBasicFont(textField:TextField, size:int = -1, letterSpacing:Number = -61, leading:Object = null, color:uint = 0, bold:Boolean = false, italic:Boolean = false):void
		{
			color = (color != 0 ? color : uint(textField.defaultTextFormat.color));
			size = (size != -1 ? size : uint(textField.defaultTextFormat.size));
			var format:TextFormat = Fonts.getBasicFont(size, color, bold, italic);
			format.letterSpacing = (letterSpacing != -61 ? letterSpacing : num(textField.defaultTextFormat.letterSpacing));
			format.leading = (leading != null ? leading : num(textField.defaultTextFormat.leading));
			Fonts.setFormat(textField, format);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 
		// > UTILS
		// 
		// 
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static function setFormat(textField:TextField, textFormat:TextFormat, resize:Boolean = true):TextFormat
		{
			return applyTextFormat(textField, textFormat, resize);
		}
		
		public static function createField(textformat:TextFormat = null, autoSize:String = 'left', type:String = 'dynamic'):TextField
		{
			return createTextField(textformat, autoSize, type);
		}

		public static function cloneField(textField:TextField):TextField
		{
			return cloneTextField(textField);
		}

		public static function cloneFormat(textField:TextField):TextFormat
		{
			return textField.getTextFormat();
		}
		
		public static function get embeddedFonts():Array
		{
			return Font.enumerateFonts(false).sortOn('fontName', Array.CASEINSENSITIVE);
		}
		
		public static function get allFonts():Array
		{
			return Font.enumerateFonts(true).sortOn('fontName', Array.CASEINSENSITIVE);
		}
	}
}