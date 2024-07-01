import 'package:application_alpha/sharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../menuScreen.dart';

class profileScreen extends StatefulWidget {
  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  TextEditingController _usernameController = TextEditingController();
  String _storedImage = '';
  String _storedUsername = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadImage();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedUsername = prefs.getString('username') ?? '';
      _usernameController.text = _storedUsername;
    });
  }

  void _saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    setState(() {
      _storedUsername = username;
    });
  }

  // Función para cargar la imagen de perfil almacenada en SharedPreferences
  void _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedImage = prefs.getString('profile_image') ?? '';
    });
  }

  // Función para guardar la imagen de perfil en SharedPreferences
  void _saveImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', imagePath);
    setState(() {
      _storedImage = imagePath;
    });
  }

  /*
  @override
  void dispose() {
    // Limpiar el controlador de texto cuando se elimina el StatefulWidget
    _usernameController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Selecciona una imagen:',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _storedImage = "user_icon.png";
                          });
                          //_saveImage(_storedImage);
                          //print('Imagen guardada: $_storedImage');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: _storedImage == "user_icon.png" ? 200 : 100,
                            height: 200, // Altura fija
                            child: Image.asset("assets/user_icon.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _storedImage = "profile_icon.png";
                              });
                              //_saveImage(_storedImage);
                              //print('Imagen guardada: $_storedImage');
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: _storedImage == "profile_icon.png" ? 200 : 100,
                                height: 200, // Altura fija
                                child: Image.asset("assets/profile_icon.png"),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _storedImage = "profile2_icon.png";
                              });
                              //_saveImage(_storedImage);
                              //print('Imagen guardada: $_storedImage');
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: _storedImage == "profile2_icon.png" ? 200 : 100,
                                height: 200, // Altura fija
                                child: Image.asset("assets/profile2_icon.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.0), // Espacio entre las imágenes y el TextField
                  TextField(
                    controller: _usernameController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String newUsername = _usernameController.text;
                          _saveUsername(newUsername);
                          _saveImage(_storedImage);
                          print('Nombre guardado: $newUsername');
                          Navigator.push(context, MaterialPageRoute(builder: (_) => menuScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                        ),
                        child: const Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      SizedBox(width: 8.0), // Espacio entre botones
                      ElevatedButton(
                        onPressed: () {
                          SharedPreferencesHelper.clearUsername();
                          Navigator.push(context, MaterialPageRoute(builder: (_) => menuScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                        ),
                        child: Text(
                            'Borrar',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
