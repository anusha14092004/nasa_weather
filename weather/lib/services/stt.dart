import 'package:speech_to_text/speech_to_text.dart';

class STTService {
  final SpeechToText _speech = SpeechToText();

  Future<void> listen(Function(String) onResult) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (val) => onResult(val.recognizedWords));
    }
  }

  void stop() => _speech.stop();
}
