import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

/*
// Función obtiene el SVG desde la URL y devuelve la cadena del SVG
Future<String> fetchSVG(String searchTerm) async {
  final translator = GoogleTranslator();
  final translatedSearchTerm = await translator.translate(searchTerm, to: 'en');
  // URL base
  const String baseUrl = "https://www.svgrepo.com/vectors/";

  // URL de búsqueda
  String url = "$baseUrl$translatedSearchTerm/";

  // Patrón para encontrar el enlace del primer SVG
  const String pattern = "https://www.svgrepo.com/show/";

  try {
    // Primer request para obtener la página con los resultados de la búsqueda
    final requestMeal = await http.get(Uri.parse(url));
    final pos1 = requestMeal.body.indexOf(pattern);
    final pos2 = requestMeal.body.indexOf('"', pos1);
    if (pos1 == -1 || pos2 == -1) {
      throw Exception('Pattern not found');
    }
    final finalURL = requestMeal.body.substring(pos1, pos2);

    // Segundo request para obtener el SVG
    final requestFirstImg = await http.get(Uri.parse(finalURL));
    final pos3 = requestFirstImg.body.indexOf("<svg");
    final pos4 = requestFirstImg.body.indexOf("svg>", pos3);
    if (pos3 == -1 || pos4 == -1) {
      throw Exception('SVG not found');
    }
    final finalSVG = requestFirstImg.body.substring(pos3, pos4 + 4);
    return finalSVG;
  } catch (e) {
    throw Exception('Error fetching SVG: $e');
  }
}*/

Future<List<String>> fetchSVGs(String searchTerm) async {
  final translator = GoogleTranslator();
  final translatedSearchTerm = await translator.translate(searchTerm, from: 'es', to: 'en');
  print(translatedSearchTerm);
  // URL base
  const String baseUrl = "https://www.svgrepo.com/vectors/";

  // URL de búsqueda
  String url = "$baseUrl$translatedSearchTerm/";
  print(url);
  // Patrón para encontrar los enlaces de los SVG
  const String pattern = "https://www.svgrepo.com/show/";

  try {
    // Primer request para obtener la página con los resultados de la búsqueda
    final requestMeal = await http.get(Uri.parse(url));

    // Encontrar todas las ocurrencias del patrón
    final matches = findAllMatches(requestMeal.body, pattern);

    // Obtener los primeros 6 enlaces de SVG
    final svgLinks = matches.take(6).toList();

    // Hacer solicitudes adicionales para obtener los SVG
    final svgs = await Future.wait(svgLinks.map((link) async {
      final requestFirstImg = await http.get(Uri.parse(link));
      final pos3 = requestFirstImg.body.indexOf("<svg");
      final pos4 = requestFirstImg.body.indexOf("svg>", pos3);
      if (pos3 == -1 || pos4 == -1) {
        throw Exception('SVG not found');
      }
      final finalSVG = requestFirstImg.body.substring(pos3, pos4 + 4);
      return finalSVG;
    }));

    return svgs;
  } catch (e) {
    throw Exception('Error fetching SVGs: $e');
  }
}

// Función auxiliar para encontrar todas las ocurrencias de un patrón en una cadena
List<String> findAllMatches(String text, String pattern) {
  int counter = 0;
  final matches = <String>[];
  print(text);
  print(pattern);
  int index = 0;
  while (counter < 6) {
    final pos1 = text.indexOf(pattern, index);
    if (pos1 == -1) break;
    final pos2 = text.indexOf('"', pos1);
    matches.add(text.substring(pos1, pos2));
    index = pos2 + 1;
    counter++;
  }
  print(matches);
  return matches;
}

/*
Future<String> fetchSVG() async {
  const String url = "https://www.svgrepo.com/vectors/meal/";
  const String pattern = "https://www.svgrepo.com/show/";

  // Primer request
  final requestMeal = await http.get(Uri.parse(url));
  final pos1 = requestMeal.body.indexOf(pattern);
  final pos2 = requestMeal.body.indexOf('"', pos1);
  if (pos1 == -1 || pos2 == -1) {
    throw Exception('Pattern not found');
  }
  final finalURL = requestMeal.body.substring(pos1, pos2);

  // Segundo request
  final requestFirstImg = await http.get(Uri.parse(finalURL));
  final pos3 = requestFirstImg.body.indexOf("<svg");
  final pos4 = requestFirstImg.body.indexOf("svg>", pos3);
  if (pos3 == -1 || pos4 == -1) {
    throw Exception('SVG not found');
  }
  final finalSVG = requestFirstImg.body.substring(pos3, pos4 + 4);
  return finalSVG;
}


class imageRequest extends StatefulWidget {
  const imageRequest({super.key});

  @override
  State<imageRequest> createState() => _imageScreenState();
}

class _imageScreenState extends State<imageRequest> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter HTTP Example'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchSVG(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.hasData
                    ? Text(snapshot.data!)
                    : Text('No SVG found');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> fetchSVG() async {
    const String url = "https://www.svgrepo.com/vectors/meal/";
    const String pattern = "https://www.svgrepo.com/show/";
    // First request
    final requestMeal = await http.get(Uri.parse(url));
    final pos1 = requestMeal.body.indexOf(pattern);
    final pos2 = requestMeal.body.indexOf('"', pos1);
    if (pos1 == -1 || pos2 == -1) {
      throw Exception('Pattern not found');
    }
    final finalURL = requestMeal.body.substring(pos1, pos2);
    // Second request
    final requestFirstImg = await http.get(Uri.parse(finalURL));
    final pos3 = requestFirstImg.body.indexOf("<svg");
    final pos4 = requestFirstImg.body.indexOf("svg>", pos3);
    if (pos3 == -1 || pos4 == -1) {
      throw Exception('SVG not found');
    }
    final finalSVG = requestFirstImg.body.substring(pos3, pos4 + 4);
    return finalSVG;
  }
}
*/