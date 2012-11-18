package com.ad.ui
{
	import flash.errors.IllegalOperationError;
	import flash.display.InteractiveObject;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.events.EventDispatcher;
	import flash.events.ContextMenuEvent;
	import flash.utils.getQualifiedClassName;

	/**
	 * M4inframe
	 * @version ActionScript 3.0
	 * @author Adrian Miranda
	 * @mail ad@adrianmiranda.com.br
	 */
	public class ContextMenuManager extends EventDispatcher
	{
		protected var menu:ContextMenu;
		protected var target:InteractiveObject;
		
		/**
		 * Construtora
		 * Uma referência ao objeto de classe ou à função de construtor de uma determinada ocorrência de ContextMenuManager.
		 */
		public function ContextMenuManager(target:InteractiveObject, hideBuiltInItems:Boolean = true)
		{
			this.target = target;
			menu = new ContextMenu();
			if(hideBuiltInItems) menu.hideBuiltInItems();
			this.target.contextMenu = menu;
			menu.addEventListener(ContextMenuEvent.MENU_SELECT, passEvent);
		}
		
		/**
		 * 
		 * @param caption 
		 * @param handler 
		 * @param separatorBefore 
		 * @param enabled 
		 * @param visible 
		 * @return 
		 */
		public function add(caption:String,	handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):ContextMenuItem
		{
			var result:ContextMenuItem = createItem(caption, handler, separatorBefore, enabled, visible);
			menu.customItems.push(result);
			return result;
		}
		
		/**
		 * 
		 * @param id 
		 * @param caption 
		 * @param handler 
		 * @param separatorBefore 
		 * @param enabled 
		 * @param visible 
		 * @return 
		 */
		public function insert(id:*, caption:String, handler:Function, separatorBefore:Boolean = false,	enabled:Boolean = true,	visible:Boolean = true):ContextMenuItem
		{
			var result:ContextMenuItem = createItem(caption, handler, separatorBefore, enabled, visible);
			var index:int = id is String ? getIndexByCaption(id) : id as int;
			(menu.customItems as Array).splice(index, 0, result);
			return result;
		}
		
		/**
		 * 
		 * @param caption 
		 * @param handler 
		 * @param separatorBefore 
		 * @param enabled 
		 * @param visible 
		 * @return ContextMenuItem 
		 */
		protected function createItem(caption:String, handler:Function, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):ContextMenuItem
		{
			var result:ContextMenuItem = new ContextMenuItem(caption, separatorBefore, enabled, visible);
			result.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, handler);
			result.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, passEvent);
			return result;
		}
		
		/**
		 * 
		 * @param id
		 */
		public function remove(id:*):void
		{
			if(id is String)
			{
				id = getIndexByCaption(id);
			}
			customItems.splice(id as Number, 1);
		}
		
		/**
		 * 
		 */
		public function hideBuiltInItems():void
		{
			menu.hideBuiltInItems();
		}
		
		/**
		 * 
		 * @param id 
		 * @return ContextMenuItem 
		 */
		public function getItem(id:*):ContextMenuItem
		{
			if(id is String)
			{
				id = getIndexByCaption(id);
			}
			return menu.customItems[id];
		}
		
		/**
		 * 
		 * @param caption 
		 * @return int 
		 */
		protected function getIndexByCaption(caption:String):int
		{
			for ( var uI:uint = 0; uI < menu.customItems.length; uI++ )
			{
				if(menu.customItems[uI].caption == caption)
				{
					return uI;
				}
			}
			return -1;
		}
		
		/**
		 * 
		 */
		public function get customItems():Array
		{
			return menu.customItems;
		}
		
		/**
		 * 
		 */
		public function get builtInItems():ContextMenuBuiltInItems
		{
			return menu.builtInItems;
		}
		
		/**
		 * 
		 */
		public function get contextMenu():ContextMenu
		{
			return menu;
		}
		
		/**
		 * 
		 * @param event
		 */
		protected function passEvent(event:ContextMenuEvent):void
		{
			dispatchEvent(new ContextMenuEvent(event.type, event.bubbles, event.cancelable, event.mouseTarget, event.contextMenuOwner));
		}
	}
}