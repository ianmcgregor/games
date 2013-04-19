package me.ianmcgregor.nanotech.spatials.gfx {
	import org.si.sion.SiONDriver;
	import feathers.controls.Button;
	import feathers.controls.Slider;
	import feathers.themes.MinimalMobileTheme;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;

	import org.si.sion.SiONVoice;
	import org.si.sion.utils.SiONPresetVoice;

	/**
	 * @author ianmcgregor
	 */
	public class SiONVoiceSelector extends Sprite {
		private var _voices : SiONPresetVoice;
		private var _selectedCategory : Array;
		private var _selectedVoice : SiONVoice;
		private var _refs : Vector.<SiONSoundVO>;
		private var _selectedRef : SiONSoundVO;
		private var _ref : Control;
		private var _cat : Control;
		private var _voice : Control;
		private var _note : Control;
		private var _length : Control;
		private var _copy : Button;
		private var _play : Button;

		public function SiONVoiceSelector(refs : Vector.<SiONSoundVO>) {
			super();

			_refs = refs;
//			trace(SiONSounds.toString());

//			DeviceCapabilities.dpi = 163;
//			// 326;
//			DeviceCapabilities.screenPixelWidth = 1024;
//			DeviceCapabilities.screenPixelHeight = 768;

			new MinimalMobileTheme(this, true, false);
//			new MetalWorksMobileTheme(Starling.current.stage);
//			new AeonDesktopTheme(Starling.current.stage);
//			 new AzureMobileTheme(Starling.current.stage);

			// sion
			_voices = new SiONPresetVoice();

			// trace all voices
			// DebugUtils.traceObject(_voices, "\t");

			// refs
			addChild(_ref = new Control("REF", onRefSliderChange));
			_ref.updateLength(_refs.length);

			// category
			addChild(_cat = new Control("CATEGORY", onCategorySliderChange));
			_cat.updateLength(_voices.categolies.length);

			// voice
			addChild(_voice = new Control("VOICE", onVoiceSliderChange));

			// note
			addChild(_note = new Control("NOTE", onNoteSliderChange));
			_note.updateMinMax(0, 100);

			// length
			addChild(_length = new Control("LENGTH", onLengthSliderChange));
			_length.updateMinMax(1, 4);
			
			// copy
			addChild(_play = new Button());
			_play.width = 80;
			_play.label = "PLAY";
			_play.addEventListener(Event.TRIGGERED, onPlayTriggered);
			
			// copy
			addChild(_copy = new Button());
			_copy.width = 80;
			_copy.label = "TRACE";
			_copy.addEventListener(Event.TRIGGERED, onCopyTriggered);
			//
			selectRef(0);

			//
			updateLayout();
			
		}

		private function onPlayTriggered(event : Event) : void {
			event;
			var voice: SiONVoice = _voices[_selectedRef.category + String(_selectedRef.voice)];
			if( voice ) {
				voice.velocity = int(256 * _selectedRef.volume);
				voice.updateVolumes = true;
				SiONDriver.mutex.noteOn(_selectedRef.note, voice, _selectedRef.length);
			}
		}

		private function onCopyTriggered(event : Event) : void {
			event;
			trace("------------------------------------------");
			trace(SiONSounds.toString());
			trace("------------------------------------------");
		}

		private function onRefSliderChange(event : Event) : void {
			var value : Number = ( event.target as Slider ).value;
			selectRef(value);
		}

		private function onCategorySliderChange(event : Event) : void {
			var value : Number = ( event.target as Slider ).value;
			selectCategory(value);
		}

		private function onVoiceSliderChange(event : Event) : void {
			var value : Number = ( event.target as Slider ).value;
			selectVoice(value);
		}

		private function onNoteSliderChange(event : Event) : void {
			var value : Number = ( event.target as Slider ).value;
			selectNote(value);
		}

		private function onLengthSliderChange(event : Event) : void {
			var value : Number = ( event.target as Slider ).value;
			selectLength(value);
		}

		private function selectRef(index : int) : void {
			_selectedRef = _refs[index];
			_ref.updateLength(_refs.length);
			_ref.setLabel(index + " " + _selectedRef.name);

			var cIndex : int = getCategoryIndex(_selectedRef.category);
			var vIndex : int = _selectedRef.voice;
			var n : int = _selectedRef.note;
			var l : int = _selectedRef.length;

			selectCategory(cIndex);
			selectVoice(vIndex);
			selectNote(n);
			selectLength(l);
		}

		private function getCategoryIndex(category : String) : int {
			var l : int = _voices.categolies.length;
			for (var i : int = 0; i < l; ++i) {
				if (_voices.categolies[i]["name"] == category) {
					return i;
				}
			}
			return -1;
		}

		private function selectCategory(index : int) : void {
			_cat.setValue(index);

			_selectedCategory = _voices.categolies[index];
			var catName : String = _selectedCategory["name"];

			_cat.updateLength(_voices.categolies.length);
			_cat.setLabel(index + " " + catName);

			_selectedRef.category = catName;

			_voice.updateLength(_selectedCategory.length);
			selectVoice(0);
		}

		private function selectVoice(index : int) : void {
			_voice.setValue(index);
			_selectedVoice = _selectedCategory[index];
			_voice.setLabel(index + " " + _selectedVoice.name);
			_selectedRef.voice = index;
		}

		private function selectNote(value : int) : void {
			_note.setValue(value);
			_note.setLabel(String(value));
			_selectedRef.note = value;
		}

		private function selectLength(value : int) : void {
			_length.setValue(value);
			_length.setLabel(String(value));
			_selectedRef.length = value;
		}

		private function updateLayout() : void {
			var currentX : int = 0;
			var currentY : int = 0;
			var l : int = numChildren;
			for (var i : int = 0; i < l; ++i) {
				var ob : DisplayObject = getChildAt(i);
				if(ob is Control) Control(ob).validate();
				ob.x = currentX;
				ob.y = currentY;
				currentY += int(ob.height + 1);
			}
		}
	}
}
import feathers.controls.Label;
import feathers.controls.Slider;
import feathers.events.FeathersEventType;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;

internal class Control extends Sprite {
	private var _title : String;
	private var _bg : Quad;
	private var _header : Label;
	private var _slider : Slider;
	private var _label : Label;

	public function Control(title : String, callBack : Function) {
		_title = title;
		
		addChild(_bg = new Quad(120, 50));
		_bg.color = 0x000000;

		addChild(_header = new Label());
		_header.text = title;

		addChild(_slider = new Slider());
		_slider.width = _bg.width - 4;
		_slider.minimum = 0;
		_slider.maximum = 1;
		_slider.value = 0;
		_slider.step = 1;
		_slider.addEventListener(Event.CHANGE, callBack);

		addChild(_label = new Label());
		_label.text = "";

		_label.addEventListener(FeathersEventType.INITIALIZE, onInit);
	}

	private function onInit(event : Event) : void {
		event;
		validate();
	}

	public function updateLength(length : int) : void {
		updateMinMax(0, length - 1);
	}
	
	public function updateMinMax(min: int, max: int) : void {
		_slider.minimum = min;
		_slider.maximum = max;
		_header.text = _title + " (" + min + "-" + max + ")";
	}

	public function setValue(value : int) : void {
		_slider.value = value;
	}

	public function setLabel(label : String) : void {
		_label.text = label;
	}

	public function validate() : void {
		if(!this.stage) return;
		_header.validate();
		_slider.validate(); 
		_label.validate();

		_header.x = _slider.x = _label.x = 2;
		_header.y = 2;
		_slider.y = _header.y + _header.height + 2;
		_label.y = _slider.y + _slider.height + 2;
	}
}