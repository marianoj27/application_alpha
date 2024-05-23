import 'package:application_alpha/sharedPreferencesHelper.dart';

class phrasesGenerator {
  static Future<List<String>> generate(String name) async {
    List<String> list = [];

    if (name == 'Ayuda') {
      String? userName = await SharedPreferencesHelper.getUsername();
      if (userName != '') {
        list.add("Mi nombre es $userName");
      }
      list.addAll([
        'Tengo Afasia, necesito ayuda.',
        'No sé cómo llegar a mi casa.',
        'Necesito hacer una llamada.',
      ]);
    } else if (name == 'Mercado') {
      list.addAll([
        '¿Puedo ver esto?, Por favor.',
        '¿Cuánto cuesta este?.',
        'Me gustaría comprar esto.',
      ]);
    } else if (name == 'Metro') {
      list.addAll([
        '¿Dónde está la estación de metro más cercana?',
        '¿Cuál es el camino al andén?',
      ]);
    } else {
      return [];
    }
    return list;
  }
}
