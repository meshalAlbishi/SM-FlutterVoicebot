import 'package:speech_to_text/speech_to_text.dart';

class STT {

  late SpeechToText _speech;
  late bool _isListening;
  late String _text;
  late double _confidence;

  STT() {
    _speech = SpeechToText();
    _isListening = false;
    _text = 'Press the button to speak';
    _confidence = 1.0;
  }

  double get confidence => _confidence;

  set confidence(double value) {
    _confidence = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  bool get isListening => _isListening;

  set isListening(bool value) {
    _isListening = value;
  }

  SpeechToText get speech => _speech;

  set speech(SpeechToText value) {
    _speech = value;
  }
}
