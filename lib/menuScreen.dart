import 'package:application_alpha/classes/imagesScreen.dart';
import 'package:application_alpha/classes/speechScreen.dart';
import 'package:flutter/material.dart';
import 'classes/category.dart';

class menuScreen extends StatefulWidget {

  @override
  State<menuScreen> createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {

  void navigateToScreen(String imageName) {
    if (imageName == "images_icon.png") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => imagenScreen()));
    } else if (imageName == "quotes_icon.png") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => speechScreen()));
    } else if (imageName == "profile_icon.png") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => imagenScreen()));
    }
    // Agrega más condiciones según las imágenes y pantallas que tengas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu Principal, Bienvenido!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
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

