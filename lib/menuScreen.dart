import 'package:application_alpha/classes/chatScreen.dart';
import 'package:application_alpha/classes/imagesScreen.dart';
import 'package:application_alpha/classes/profileScreen.dart';
import 'package:application_alpha/classes/speechScreen.dart';
import 'package:application_alpha/imageRequest.dart';
import 'package:flutter/material.dart';
import 'classes/category.dart';
import 'sharedPreferencesHelper.dart';

class menuScreen extends StatefulWidget {

  @override
  State<menuScreen> createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {
  String _username = '';
  String _profileImg = '';
  @override
  void initState() {
    _loadUsername();
    _loadProfileImg();
  }

  void _loadUsername() async {
    String username = await SharedPreferencesHelper.getUsername();
    setState(() {
      _username = username;
    });
  }
  void _loadProfileImg() async {
    String profileImg = await SharedPreferencesHelper.getProfileImage();
    setState(() {
      _profileImg = profileImg;
    });
  }

  void navigateToScreen(String imageName) {
    if (imageName == "images_icon.png") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => imagenScreen()));
    } else if (imageName == "quotes_icon.png") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => imageRequest()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinea los elementos al inicio y al final
          children: [
            Text(
              'Bienvenido! ${_username}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                // Navegar a la siguiente pantalla al hacer clic en la imagen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profileScreen()),
                );
              },
              child: Image.asset(
                'assets/${_profileImg}',
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"), // Ruta y nombre de tu imagen
            fit: BoxFit.cover, // Ajusta la imagen para cubrir el fondo
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent, // Establece el color del contenido como transparente para que la imagen de fondo sea visible
                child: GridView.builder(
                  itemCount: Menu.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print("object");
                          navigateToScreen(Menu[index].photo);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/" + Menu[index].photo,
                              width: 300,
                            ),
                            Text(
                              Menu[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*class _menuScreenState extends State<menuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Principal, " + "Bienvenido!"), backgroundColor: Colors.white60,),
      backgroundColor: Colors.tealAccent,
      body: Container(
        child: GridView.builder(
          itemCount: Menu.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(50),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10)
              ),
              child: GestureDetector(
                onTap: (){
                  print("CLICK");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset("assets/"+Menu[index].photo, width: 200,),
                  Text(Menu[index].name)
                  ],
                ),
              )
            );
            }
        ),
      ),
    );
  }
}*/

