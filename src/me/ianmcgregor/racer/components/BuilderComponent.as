package me.ianmcgregor.racer.components {
	import com.artemis.Component;

	/**
	 * @author ianmcgregor
	 */
	public class BuilderComponent extends Component {
		/**
		 * track 
		 */
		public var track : String;
		/**
		 * name 
		 */
		public var name : String;
		/**
		 * laps 
		 */
		public var laps : uint;
		/**
		 * changed 
		 */
		public var changed : Boolean;
		/**
		 * trackIndex 
		 */
		public var trackIndex : int;
		/**
		 * BuilderComponent 
		 */
		public function BuilderComponent() {
		}
	}
}
