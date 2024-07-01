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
    if (_selectedWords.length < 5) {
      setState(() {
        _selectedWords.add(word);
        _textController.clear();
        _updateDisplayedText();
        _updateSuggestions();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No puedes agregar más de 5 palabras'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _updateDisplayedText() {
    setState(() {
      _displayedText = _selectedWords.join(' ');
    });
  }

  void _updateSuggestions() {
    setState(() {
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
      _textController.clear();
      _displayedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '¡Hacer Frases!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
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
              style: const TextStyle(fontSize: 18),
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
                        child: Text(
                          word,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                  Center(
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          _displayedText,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  width: 2.0,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _clearText,
                icon: const Icon(
                  Icons.delete,
                  size: 25.0,
                ),
                splashColor: Colors.blue,
                highlightColor: Colors.black12,
                iconSize: 60.0,
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

