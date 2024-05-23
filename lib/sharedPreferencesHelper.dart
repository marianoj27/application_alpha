import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Función para guardar la lista de SVG y nombre
  static Future<void> saveSVG(String key, String name, String svg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Obtener la lista actual o crear una nueva si no existe
    List<List<String>> svgAndNameList = prefs.getStringList(key)?.map((item) => item.split('|')).toList() ?? [];

    // Buscar si ya existe una entrada con el mismo nombre
    int index = svgAndNameList.indexWhere((item) => item[0] == name);
    if (index != -1) {
      // Actualizar la entrada existente
      svgAndNameList[index][1] = svg;
    } else {
      // Agregar una nueva entrada
      svgAndNameList.add([name, svg]);
    }

    // Guardar la lista actualizada
    await prefs.setStringList(key, svgAndNameList.map((item) => item.join('|')).toList());
  }

  // Función para cargar la lista de SVGs y nombres
  static Future<List<List<String>>?> loadSVG(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(key);
    if (stringList != null) {
      return stringList.map((item) => item.split('|')).toList();
    }
    return null;
  }

  // Función para eliminar la lista de SVGs y nombres
  static Future<void> removeSVG(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Función para eliminar un SVG específico por nombre
  static Future<void> removeSVGByName(String key, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<List<String>> svgAndNameList = prefs.getStringList(key)?.map((item) => item.split('|')).toList() ?? [];

    svgAndNameList.removeWhere((item) => item[0] == name);

    await prefs.setStringList(key, svgAndNameList.map((item) => item.join('|')).toList());
  }

  //Profile helper
  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? '';
  }

  static Future<void> clearUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  //Si se quiere editar el nombre en otra parte de la app que no sea el profile
  static Future<void> editNewUsername(String newUsername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
  }

  static Future<String> getProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile_image') ?? 'user_icon.png';
  }

  //List helper
  static Future<List<String>> getList(String listKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(listKey) ?? [];
  }

  static Future<void> saveList(String listKey, List<String> phrases) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listKey, phrases);
  }

  static Future<void> clearList(String listKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(listKey);
  }

  static Future<void> addPhraseToList(String listKey, String phrase) async {
    List<String> phrases = await getList(listKey);
    phrases.add(phrase);
    await saveList(listKey, phrases);
  }

  static Future<void> deletePhraseFromList(String listKey, String phrase) async {
    List<String> phrases = await getList(listKey);
    phrases.remove(phrase);
    await saveList(listKey, phrases);
  }
}
