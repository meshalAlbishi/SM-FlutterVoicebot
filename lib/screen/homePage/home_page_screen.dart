import 'package:flutter/material.dart';
import 'package:ibm_watson_assistant/ibm_watson_assistant.dart';
import 'components/home_page_body.dart';
import 'package:flutter_voicebot/services/STT.dart';
import 'package:flutter_voicebot/services/TTS.dart';


import 'components/home_page_sttIcon.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  STT _stt = STT();
  TTS _tts = TTS();
  // IBM _ibm = IBM();
  // late var bott = createBot();

  @override
  void initState() {
    super.initState();
    createBot();
    _speak("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: createIcon(context, _stt.isListening, _listen),
      body: createBody(_stt.text),
    );
  }

  void _listen() async {
    if (!_stt.isListening) {
      bool available = await _stt.speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() => _stt.isListening = true);

        _stt.speech.listen(
            onResult: (val) => setState(() {
                  _stt.text = val.recognizedWords;
                  if (val.hasConfidenceRating && val.confidence > 0) {
                    _stt.confidence = val.confidence;
                  }
                }));
      }
    } else {
      setState(() => _stt.isListening = false);
      _stt.speech.stop();

      // do ibm watson
    }
  }

  void _speak(text) {
    _tts.speak(text);
  }

  void createBot() async{
    print('p');
    final auth = IbmWatsonAssistantAuth(
      assistantId: '8d02e15e-5025-44ca-b959-5ce3f97fb585',
      url: 'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/c4c20ac7-0e61-4440-b921-1ad79488a627/v2/assistants/8d02e15e-5025-44ca-b959-5ce3f97fb585/sessions',
      apikey: 'TPjYQyz8FwS_tr_E1xgCFkFkZAnZaIbUt629dj3-U9XA',
    );

    final bot = IbmWatsonAssistant(auth);

    final sessionId = await bot.createSession();
    print(sessionId);

    final botRes = await bot.sendInput('good', sessionId: sessionId);
    print(botRes.responseText);

    bot.deleteSession(sessionId!);

    try {
      final logs = await bot.logs();
      print(logs);
    } catch (e) {
      print('Logging endpoint only available for paid plans.\n$e');
    }
  }
}
