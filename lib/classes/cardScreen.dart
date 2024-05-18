import 'package:flutter/material.dart';
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
  }

  Future<void> speak(String text) async {
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
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeletePhrase(String phrase) async {
    // Eliminar la frase
    setState(() {
      savedPhrases.remove(phrase);
    });
    await SharedPreferencesHelper.deletePhraseFromList(widget.name, phrase);
  }

  Future<void> _addPhrase(String newPhrase) async {
    setState(() {
      savedPhrases.add(newPhrase);
    });
    await SharedPreferencesHelper.addPhraseToList(widget.name,newPhrase);
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
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(enteredPhrase);
              },
              child: Text('Añadir'),
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
              child: Text('Eliminar todas'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.tealAccent,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Borrar todas las frases'),
                  onTap: _clearAllPhrases,
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
              SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () => _showAddPhraseDialog(context),
                child: Text("Añadir frase"),
              ),
              SizedBox(height: 35.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/${widget.selectedImage}",
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
              SizedBox(height: 35.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...phrases.map((phrase) {
                    return ElevatedButton(
                      onPressed: () {
                        speak(phrase);
                      },
                      child: Text(phrase),
                    );
                  }).toList(),
                  //SizedBox(height: 15.0),
                  ...savedPhrases.map((phrase) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            speak(phrase);
                          },
                          child: Text(phrase),
                        ),
                        IconButton(
                          onPressed: () {
                            _deletePhrase(phrase);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
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