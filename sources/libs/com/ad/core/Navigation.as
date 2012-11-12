package com.ad.core {
	import com.ad.data.Language;
	
	public final class Navigation extends NavigationData {
		
		public function Navigation(key:String = null) {
			super(key);
		}

		public static function getInstance(key:String = null):Navigation {
			if (!hasInstance(key)) instances[key] = new Navigation(key);
			return instances[key] as Navigation;
		}
	}
}