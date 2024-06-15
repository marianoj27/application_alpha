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
      Navigator.push(context, MaterialPageRoute(builder: (context) => speechScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Esta línea elimina la flecha de volver atrás
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bienvenido ${_username}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profileScreen()),
                );
              },
              child: Image.asset(
                'assets/${_profileImg}',
                width: 45,
                height: 45,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
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
                      margin: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          print("object");
                          navigateToScreen(Menu[index].photo);
                        },
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              navigateToScreen(Menu[index].photo);
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  width: 250,
                                  child: Image.asset(
                                    "assets/" + Menu[index].photo,
                                    width: 200,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  Menu[index].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
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

