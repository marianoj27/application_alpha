import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
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
