import 'package:text_to_speech/text_to_speech.dart';

class TTS {
  late TextToSpeech _tts;

  TTS() {
    this._tts = TextToSpeech();
  }

  void speak(String text) {
    _tts.speak(text);
  }

  TextToSpeech get tts => _tts;
}
