import 'package:flutter/material.dart';
import 'package:nutriapp/constant/colors.dart';
import 'package:nutriapp/providers/getdishprovider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SmartSearch extends StatefulWidget {
  const SmartSearch({Key? key}) : super(key: key);

  @override
  State<SmartSearch> createState() => _SmartSearchState();
}

class _SmartSearchState extends State<SmartSearch> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }
  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
  setState(() {
    _lastWords = result.recognizedWords;
    print("_lastWords$_lastWords");
    if (_lastWords.isNotEmpty && Provider.of<GetDishProvider>(context, listen: false).dishList!.isEmpty) {
      Provider.of<GetDishProvider>(context, listen: false).selectedWord(_lastWords);
      _stopListening();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDishProvider>(
      builder: (context, getdishprovider, child) {
        if (_lastWords != "" && getdishprovider.dishList!.isEmpty) {
          getdishprovider.selectedWord(_lastWords);
           _stopListening();
        }
        return Scaffold(
          appBar: AppBar(backgroundColor: ColorClass.baseColor),
          drawer: Drawer(
            backgroundColor: ColorClass.baseColor,
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('Smart Search'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/smartsearch');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.train,
                  ),
                  title: const Text('Page 2'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        // If listening is active show the recognized words
                        _speechToText.isListening
                            ? '$_lastWords'

                            // If listening isn't active but could be tell the user
                            // how to start it, otherwise indicate that speech
                            // recognition is not yet ready or not supported on
                            // the target device
                            : _speechEnabled
                                ? 'Tap the microphone to start listening...'
                                : 'Speech not available',
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome ",
                        style: TextStyle(
                          color: ColorClass.baseColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "to Smart Search",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorClass.baseColor,
                                    shape: CircleBorder(),
                                    fixedSize: Size(80, 80),
                                    padding: EdgeInsets.all(14),
                                  ),
                                  onPressed: _startListening,
                                  child: const Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                            SizedBox(width: 30,),
                             Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: CircleBorder(),
                                fixedSize: Size(80, 80),
                                padding: EdgeInsets.all(14),
                              ),
                              onPressed:() {
                                _stopListening();
                                getdishprovider.getDishfromvoice();
                                Navigator.pushNamed(context, '/customizesearch');
                              },
                              child: const Icon(
                                Icons.stop,
                                color: Colors.white,
                                size: 25,
                              )),
                        ),
                          ],
                        ),
                        
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Press To Start',
                          style: TextStyle(
                              color: ColorClass.baseColor,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 1.0,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
