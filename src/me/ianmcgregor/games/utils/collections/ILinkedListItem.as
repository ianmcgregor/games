package me.ianmcgregor.games.utils.collections {
	/**
	 * @author ian
	 */
	public interface ILinkedListItem {
		/**
		 * prev 
		 */
		function get prev(): ILinkedListItem;
		/**
		 * @private
		 */
		function set prev(item: ILinkedListItem): void;
		/**
		 * next 
		 */
		function get next(): ILinkedListItem;
		/**
		 * @private
		 */
		function set next(item: ILinkedListItem): void;
	}
}
