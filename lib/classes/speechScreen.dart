import 'package:application_alpha/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:application_alpha/consts.dart';

class speechScreen extends StatefulWidget {
  const speechScreen({super.key});

  @override
  State<speechScreen> createState() => _speechScreenState();
}

class _speechScreenState extends State<speechScreen> {
  final TextEditingController _textController = TextEditingController();
  List<String> _suggestions = [];
  List<String> _selectedWords = [];
  String _displayedText = '';
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    configureTts();
  }

  Future<void> configureTts() async {
    await flutterTts.setLanguage('es-ES');
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  void speak() async {
    try {
      await flutterTts.speak(_displayedText);
    } catch (e) {
      print('Error speaking text: $e');
    }
  }

  void _onTextChanged(String text) {
    setState(() {
      _suggestions = wordSuggestions.keys.where((word) => word.startsWith(text)).toList();
    });
  }

  void _onSuggestionTapped(String word) {
    setState(() {
      _selectedWords.add(word);
      //_suggestions.clear();
      _textController.clear();
      _updateDisplayedText();
      _updateSuggestions();
    });
  }

  void _updateDisplayedText() {
    setState(() {
      _displayedText = _selectedWords.join(' ');
    });
  }

  void _updateSuggestions() {
    setState(() {
      print(_selectedWords);
      if (_selectedWords.isNotEmpty) {
        final lastWord = _selectedWords.last;
        _suggestions = wordSuggestions[lastWord] ?? [];

        if (_selectedWords.length > 1) {
          final secondLastWord = _selectedWords[_selectedWords.length - 2];
          final continuationSuggestions = wordSuggestions[secondLastWord + ' ' + lastWord] ?? [];
          _suggestions.addAll(continuationSuggestions);
        }
      } else {
        _suggestions = [];
      }
    });
  }

  void _clearText() {
    setState(() {
      _selectedWords.clear();
      //_suggestions.clear();
      _textController.clear();
      _displayedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '¡Hacer Frases!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              onChanged: _onTextChanged,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Escribe una palabra',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _suggestions
                          .map((word) => ElevatedButton(
                        onPressed: () => _onSuggestionTapped(word),
                        child: Text(word,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _displayedText,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Color de fondo del cuadro
                border: Border.all(
                  width: 2.0, // Ancho del borde
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de la sombra con opacidad
                    spreadRadius: 2, // Extensión de la sombra
                    blurRadius: 5, // Desenfoque de la sombra
                    offset: Offset(3, 3), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _clearText,
                icon: const Icon(
                  Icons.delete,
                  size: 25.0, // Cambia el tamaño del icono
                ),
                splashColor: Colors.blue, // Color del splash (onda) cuando se presiona el botón
                highlightColor: Colors.black12, // Color al mantener presionado el botón
                iconSize: 60.0, // Tamaño del área interactiva del botón
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: speak,
        child: const Icon(Icons.volume_up),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}

