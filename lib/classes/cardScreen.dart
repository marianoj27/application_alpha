import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:application_alpha/widgets/phrases_generator.dart';

import '../sharedPreferencesHelper.dart';

class cardScreen extends StatefulWidget {
  final String selectedImage;
  final String name;

  const cardScreen({Key? key, required this.selectedImage, required this.name}) : super(key: key);

  @override
  State<cardScreen> createState() => _cardScreenState();
}

class _cardScreenState extends State<cardScreen> {
  FlutterTts flutterTts = FlutterTts();
  List<String> phrases = [];
  List<String> savedPhrases = [];
  double speechRate = 0.4; // Define el estado de la velocidad de lectura

  @override
  void initState() {
    super.initState();
    configureTts();
    _loadPhrases();
  }

  Future<void> _loadPhrases() async {
    List<String> phrases = await phrasesGenerator.generate(widget.name);
    setState(() {
      this.phrases = phrases;
    });

    SharedPreferencesHelper.getList(widget.name).then((value) {
      setState(() {
        savedPhrases = value;
      });
    });
  }

  Future<void> configureTts() async {
    await flutterTts.setLanguage('es-ES');
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(speechRate);
  }

  Future<void> speak(String text) async {
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(text);
  }

  Future<void> _deletePhrase(String phrase) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar esta frase?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _confirmDeletePhrase(phrase);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color de fondo del botón
              ),
              child: Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeletePhrase(String phrase) async {
    setState(() {
      savedPhrases.remove(phrase);
    });
    await SharedPreferencesHelper.deletePhraseFromList(widget.name, phrase);
  }

  Future<void> _addPhrase(String newPhrase) async {
    setState(() {
      savedPhrases.add(newPhrase);
    });
    await SharedPreferencesHelper.addPhraseToList(widget.name, newPhrase);
  }

  Future<void> _showAddPhraseDialog(BuildContext context) async {
    String newPhrase = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String enteredPhrase = '';
        return AlertDialog(
          title: Text('Añadir Frase'),
          content: SingleChildScrollView(
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Ingrese la nueva frase'),
              onChanged: (value) {
                enteredPhrase = value;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(enteredPhrase);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
              child: const Text(
                'Añadir',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        );
      },
    );

    if (newPhrase != null && newPhrase.isNotEmpty) {
      _addPhrase(newPhrase);
    }
  }

  Future<void> _clearAllPhrases() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar todas las frases?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _confirmClearAllPhrases();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color de fondo del botón
              ),
              child: Text(
                'Eliminar todas',
                style: TextStyle(color: Colors.white), // Color del texto
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmClearAllPhrases() async {
    setState(() {
      savedPhrases.clear();
    });
    await SharedPreferencesHelper.clearList(widget.name);
  }

  void _increaseSpeechRate() {
    setState(() {
      speechRate = (speechRate + 0.2).clamp(0.2, 0.6); // Aumenta la velocidad de lectura
      flutterTts.setSpeechRate(speechRate);
    });
  }

  void _decreaseSpeechRate() {
    setState(() {
      speechRate = (speechRate - 0.2).clamp(0.2, 0.6); // Disminuye la velocidad de lectura
      flutterTts.setSpeechRate(speechRate);
    });
  }

  void _setSpeechRate(double rate) {
    setState(() {
      speechRate = rate;
      flutterTts.setSpeechRate(speechRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/image');
          },
        ),
        title: Text(
          widget.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.greenAccent,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: _clearAllPhrases,
                  child: const Row(
                    children: [
                      Icon(Icons.delete, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'Borrar todas las frases creadas',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () => _showAddPhraseDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 30, color: Colors.white),
                    SizedBox(width: 2.0),
                    Text(
                      "Añadir frase",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.selectedImage.startsWith('<svg'))
                    SvgPicture.string(
                      widget.selectedImage,
                      width: 150,
                      height: 150,
                    )
                  else
                    Image.asset(
                      "assets/${widget.selectedImage}",
                      width: 150,
                      height: 150,
                    ),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Velocidad del sonido:',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  //SizedBox(width: 5),
                  Expanded(
                    child: Slider(
                      value: speechRate,
                      min: 0.2,
                      max: 0.6,
                      divisions: 2, // Divisiones en el slider
                      label: speechRate.toStringAsFixed(1),
                      onChanged: (double value) {
                        _setSpeechRate(value);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...phrases.map((phrase) {
                    return ElevatedButton(
                      onPressed: () {
                        speak(phrase);
                      },
                      child: Text(
                        phrase,
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  ...savedPhrases.map((phrase) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () {
                                speak(phrase);
                              },
                              child: Text(
                                phrase,
                                style: TextStyle(fontSize: 17, color: Colors.black),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _deletePhrase(phrase);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}