package me.ianmcgregor.racer.spatials {
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.PickerList;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.data.ListCollection;
	import feathers.system.DeviceCapabilities;
	import feathers.themes.AzureMobileTheme;

	import me.ianmcgregor.games.artemis.spatials.Spatial;
	import me.ianmcgregor.games.base.GameContainer;
	import me.ianmcgregor.racer.components.BuilderComponent;
	import me.ianmcgregor.racer.constants.State;
	import me.ianmcgregor.racer.constants.Tracks;

	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;

	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	/**
	 * @author McFamily
	 */
	public final class BuilderSpatial extends Spatial {
		/**
		 * _builder 
		 */
		private var _builder : BuilderComponent;
		/**
		 * _gfx 
		 */
		private var _gfx : Sprite;
		/**
		 * _output 
		 */
		private var _output : TextInput;
		/**
		 * _button 
		 */
		private var _button : Button;
		/**
		 * _bg 
		 */
		private var _bg : Quad;
		/**
		 * _nameInput 
		 */
		private var _nameInput : TextInput;
		/**
		 * _nameLabel 
		 */
		private var _nameLabel : Label;
		/**
		 * _trackPickerList 
		 */
		private var _trackPickerList : PickerList;
		/**
		 * _lapsSlider 
		 */
		private var _lapsSlider : Slider;
		/**
		 * _toggleSwitch 
		 */
		private var _toggleSwitch : ToggleSwitch;
		/**
		 * _container 
		 */
		private var _container : Sprite;
		/**
		 * _lapsLabel 
		 */
		private var _lapsLabel : Label;
		/**
		 * _lapsSliderValueLabel 
		 */
		private var _lapsSliderValueLabel : Label;
		/**
		 * _trackPickerListLabel 
		 */
		private var _trackPickerListLabel : Label;
		/**
		 * BuilderSpatial 
		 * 
		 * @param world 
		 * @param owner 
		 * 
		 * @return 
		 */
		public function BuilderSpatial(world : World, owner : Entity) {
			super(world, owner);
		}
		
		/**
		 * initalize 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function initalize(g : GameContainer) : void {
			g;
			/**
			 * mapper 
			 */
			var mapper : ComponentMapper = new ComponentMapper(BuilderComponent, _world);
			_builder = mapper.get(_owner);

			_gfx = new Sprite();
			
			DeviceCapabilities.dpi = 163;//326;
			DeviceCapabilities.screenPixelWidth = 960;
			DeviceCapabilities.screenPixelHeight = 640;
			
//			new MinimalMobileTheme(Starling.current.stage);
//			new MetalWorksMobileTheme(Starling.current.stage);
//			new AeonDesktopTheme(Starling.current.stage);
			new AzureMobileTheme(Starling.current.stage);
			
			_gfx.addChild(_toggleSwitch = new ToggleSwitch());
			_toggleSwitch.isSelected = false;
			_toggleSwitch.addEventListener(Event.CHANGE, onToggleSwitchChange);
			
			_gfx.addChild(_container = new Sprite());
			_container.visible = false;
			
			_container.addChild(_bg = new Quad(400, 400));
			_bg.color = 0x000000;
			
			_container.addChild(_nameLabel = new Label());
			_nameLabel.text = "NAME";
			
			_container.addChild(_nameInput = new TextInput());
			_nameInput.addEventListener(Event.CHANGE, onTrackNameChange);
			
			_container.addChild(_lapsLabel = new Label());
			_lapsLabel.text = "LAPS";
			
			_container.addChild(_lapsSlider = new Slider());
			_lapsSlider.minimum = 1;
			_lapsSlider.maximum = 10;
			_lapsSlider.value = 3;
			_lapsSlider.step = 1;
			_lapsSlider.addEventListener(Event.CHANGE, onLapsSliderChange);
			
			_container.addChild(_lapsSliderValueLabel = new Label());
			_lapsSliderValueLabel.text = _lapsSlider.value.toString();
			
			_container.addChild(_trackPickerListLabel = new Label());
			_trackPickerListLabel.text = "EDIT TRACK";
			
			_container.addChild(_trackPickerList = new PickerList());
			_trackPickerList.addEventListener(Event.CHANGE, onTrackPickerChange);
			
			/**
			 * tracks 
			 */
			var tracks: Array = Tracks.TRACK_MAPS;
			/**
			 * items 
			 */
			var items:Array = [];
			items[items.length] = {index: -1, text: "SELECT:"};
			/**
			 * l 
			 */
			var l: int = tracks.length;
			/**
			 * i 
			 */
			for (var i : int = 0; i < l; ++i) {
				items[items.length] = {index: i, text: tracks[i][0]};				
			}
			_trackPickerList.dataProvider = new ListCollection(items);

			/**
			 * exampleItem 
			 */
			var exampleItem : String = "LONG TRACK NAME!";
			
			_trackPickerList.typicalItem = {text:exampleItem};
			_trackPickerList.labelField = "text";

			//notice that we're setting typicalItem on the list separately. we
			//may want to have the list measure at a different width, so it
			//might need a different typical item than the picker list's button.
			_trackPickerList.listProperties["typicalItem"] = {text: exampleItem};

			//notice that we're setting labelField on the item renderers
			//separately. the default item renderer has a labelField property,
			//but a custom item renderer may not even have a label, so
			//PickerList cannot simply pass its labelField down to item
			//renderers automatically
			_trackPickerList.listProperties.@itemRendererProperties["labelField"] = "text";
			
				
//				var l: int = _trackPickerList.dataProvider.length;
//				for (var i : int = 0; i < l; ++i) {
//					var item: Object = _trackPickerList.dataProvider.getItemAt(i);
//					if( uint(item["text"]) == _builder.laps ){
//						_trackPickerList.selectedItem = item;
//						break;
//					}
//				}
			
			_container.addChild(_button = new Button());
			_button.width = 360;
			_button.label = "GET TRACK DATA";
			_button.addEventListener(Event.TRIGGERED, onTraceTriggered);

			_container.addChild(_output = new TextInput());
			_output.setSize(360, 160);
			
			// stop touches propogating
			_gfx.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		/**
		 * onLapsSliderChange 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onLapsSliderChange(event : Event) : void {
			event.stopImmediatePropagation();
			_lapsSliderValueLabel.text = _lapsSlider.value.toString();
			_builder.laps = uint(_lapsSlider.value);
			_builder.changed = true;
		}

		/**
		 * onToggleSwitchChange 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onToggleSwitchChange(event : Event) : void {
			event.stopImmediatePropagation();
			_container.visible = _toggleSwitch.isSelected;
		}

		/**
		 * onTrackPickerChange 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTrackPickerChange(event : Event) : void {
			event.stopImmediatePropagation();
			//_builder.laps = uint(_trackPickerList.selectedItem["text"]);
			/**
			 * index 
			 */
			var index: int = int(_trackPickerList.selectedItem["index"]);
			_builder.trackIndex = index;
			_builder.changed = true;
		}

		/**
		 * onTrackNameChange 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTrackNameChange(event : Event) : void {
			event.stopImmediatePropagation();
			_builder.name = _nameInput.text;
			_builder.changed = true;
		}

		/**
		 * onTouch 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTouch(event : TouchEvent) : void {
			event.stopImmediatePropagation();
		}

		/**
		 * onTraceTriggered 
		 * 
		 * @param event 
		 * 
		 * @return 
		 */
		private function onTraceTriggered(event : Event) : void {
			event.stopImmediatePropagation();
			_output.text = _builder.track;
		}
		
		/**
		 * render 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function render(g : GameContainer) : void {
			if(g.state != State.BUILD) return;
			
			if (!g.contains(_gfx)) {
				g.addChild(_gfx);
				
				// validate
				
				_toggleSwitch.validate();
				_button.validate();
				_output.validate();
				_nameLabel.validate();
				_nameInput.validate();
				_lapsLabel.validate();
				_trackPickerListLabel.validate();
				_trackPickerList.validate();
				_lapsSlider.validate();
				_lapsSliderValueLabel.validate();
				
				// layout
				
				_container.y = _toggleSwitch.y + _toggleSwitch.height;
				
				_nameLabel.x = 20;
				_nameLabel.y = 20;

				_nameInput.x = _nameLabel.x;
				_nameInput.y = _nameLabel.y + _nameLabel.height;
				
				_lapsLabel.x = 200;
				_lapsLabel.y = _nameLabel.y;
				
				_lapsSlider.x = _lapsLabel.x;
				_lapsSlider.y = _lapsLabel.y + _lapsLabel.height + 10;
				
				_lapsSliderValueLabel.x = _lapsSlider.x + _lapsSlider.width;
				_lapsSliderValueLabel.y = _lapsSlider.y;
				
				_trackPickerListLabel.x = _nameLabel.x;
				_trackPickerListLabel.y = _nameInput.y + _nameInput.height + 5;
				
				_trackPickerList.x = _trackPickerListLabel.x;
				_trackPickerList.y = _trackPickerListLabel.y + _trackPickerListLabel.height;
				
				_button.x = _nameLabel.x;
				_button.y = _trackPickerList.y + _trackPickerList.height + 20;
				
				_output.x = _button.x;
				_output.y = _button.y + _button.height + 2;
				
				// set initial data
				setTrackData();
			}
			
			if(_output.text != _builder.track){
				_output.text = _builder.track;
			}
			if(_nameInput.text != _builder.name){
				setTrackData();
			}
			
//			_gfx.x = g.x + (g.getWidth() - _gfx.width) * 0.5;
			_gfx.x = 200;
			_gfx.y = 0;
		}

		/**
		 * setTrackData 
		 * 
		 * @return 
		 */
		private function setTrackData() : void {
			_nameInput.text = _builder.name;
			_lapsSlider.value = _builder.laps;
			_lapsSliderValueLabel.text = _lapsSlider.value.toString();
		}


		/**
		 * remove 
		 * 
		 * @param g 
		 * 
		 * @return 
		 */
		override public function remove(g : GameContainer) : void {
		}
	}
}
