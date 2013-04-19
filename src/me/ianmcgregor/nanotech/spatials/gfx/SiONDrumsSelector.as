package me.ianmcgregor.nanotech.spatials.gfx {
	import feathers.controls.Button;
	import feathers.themes.MinimalMobileTheme;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;

	import org.si.sound.DrumMachine;

	/**
	 * @author ianmcgregor
	 */
	public class SiONDrumsSelector extends Sprite {
		private var _copy : Button;
		private var _kickVoice : Control;
		private var _kickPattern : Control;
		private var _snareVoice : Control;
		private var _snarePattern : Control;
		private var _hiHatVoice : Control;
		private var _hiHatPattern : Control;
		private var _bpm : Control;

		public function SiONDrumsSelector() {
			super();

//			DeviceCapabilities.dpi = 163;
//			// 326;
//			DeviceCapabilities.screenPixelWidth = 1024;
//			DeviceCapabilities.screenPixelHeight = 768;

			new MinimalMobileTheme(this, true, false);
//			new MetalWorksMobileTheme(Starling.current.stage);
//			 new AeonDesktopTheme(Starling.current.stage);
			// new AzureMobileTheme(Starling.current.stage);
			
			var drums: DrumMachine = new DrumMachine();
			
			// bpm
			addChild(_bpm = new Control("BPM", onSliderChange));
			_bpm.updateMinMax(0, 200);
			_bpm.setValue(SiONSounds.BPM);

			// kick
			addChild(_kickVoice = new Control("KICK VOICE", onSliderChange));
			_kickVoice.updateMinMax(0, drums.bassVoiceNumberMax);
			_kickVoice.setValue(SiONSounds.KICK_VOICE);
			addChild(_kickPattern = new Control("KICK PATTERN", onSliderChange));
			_kickPattern.updateMinMax(0, drums.bassPatternNumberMax);
			_kickPattern.setValue(SiONSounds.KICK_PATTERN);

			// snare
			addChild(_snareVoice = new Control("SNARE VOICE", onSliderChange));
			_snareVoice.updateMinMax(0, drums.snareVoiceNumberMax);
			_snareVoice.setValue(SiONSounds.SNARE_VOICE);
			addChild(_snarePattern = new Control("SNARE PATTERN", onSliderChange));
			_snarePattern.updateMinMax(0, drums.snarePatternNumberMax);
			_snarePattern.setValue(SiONSounds.SNARE_PATTERN);

			// hi-hat
			addChild(_hiHatVoice = new Control("HIHAT VOICE", onSliderChange));
			_hiHatVoice.updateMinMax(0, drums.hihatVoiceNumberMax);
			_hiHatVoice.setValue(SiONSounds.HIHAT_VOICE);
			addChild(_hiHatPattern = new Control("HIHAT PATTERN", onSliderChange));
			_hiHatPattern.updateMinMax(0, drums.hihatPatternNumberMax);
			_hiHatPattern.setValue(SiONSounds.HIHAT_PATTERN);

			// copy
			addChild(_copy = new Button());
			_copy.width = 80;
			_copy.label = "TRACE";
			_copy.addEventListener(Event.TRIGGERED, onCopyTriggered);
			//
			updateLayout();
		}

		private function onSliderChange(event : Event) : void {
//			 ( event.target as Slider ).value
			event;

			if(_bpm) SiONSounds.BPM = _bpm.getValue();

			if(_kickVoice) SiONSounds.KICK_VOICE = _kickVoice.getValue();
			if(_kickPattern) SiONSounds.KICK_PATTERN = _kickPattern.getValue();

			if(_snareVoice) SiONSounds.SNARE_VOICE = _snareVoice.getValue();
			if(_snarePattern) SiONSounds.SNARE_PATTERN = _snarePattern.getValue();
	
			if(_hiHatVoice) SiONSounds.HIHAT_VOICE = _hiHatVoice.getValue();
			if(_hiHatPattern) SiONSounds.HIHAT_PATTERN = _hiHatPattern.getValue();
		}

		private function onCopyTriggered(event : Event) : void {
			event;
			trace("------------------------------------------");
			trace("public static var BPM : int = " + SiONSounds.BPM + ";");
			trace("public static var KICK_VOICE : int = " + SiONSounds.KICK_VOICE + ";");
			trace("public static var KICK_PATTERN : int = " + SiONSounds.KICK_PATTERN + ";");
			trace("public static var SNARE_VOICE : int = " + SiONSounds.SNARE_VOICE + ";");
			trace("public static var SNARE_PATTERN : int = " + SiONSounds.SNARE_PATTERN + ";");
			trace("public static var HIHAT_VOICE : int = " + SiONSounds.HIHAT_VOICE + ";");
			trace("public static var HIHAT_PATTERN : int = " + SiONSounds.HIHAT_PATTERN + ";");
			trace("------------------------------------------");
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
		_slider.addEventListener(Event.CHANGE, function(event: Event): void{
			_label.text = String(_slider.value);
			callBack(event);
		});

		addChild(_label = new Label());
		_label.text = "";

		_label.addEventListener(FeathersEventType.INITIALIZE, onInit);
	}

	private function onInit(event : Event) : void {
		event;
		validate();
	}

	public function updateLength(length : int) : void {
//		_slider.maximum = length - 1;
//		_header.text = _title + " (" + length + ")";
		
		updateMinMax(0, length - 1);
	}
	
	public function updateMinMax(min: int, max: int) : void {
		_slider.minimum = min;
		_slider.maximum = max;
		_header.text = _title + " (" + min + "-" + max + ")";
	}

	public function getValue() : int {
		return _slider.value;
	}

	public function setValue(value : int) : void {
		_slider.value = value;
		_label.text = String(value);
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