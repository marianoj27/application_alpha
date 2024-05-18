import 'package:application_alpha/classes/cardScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_image.dart';
import '../widgets/icon_window.dart';

class imagenScreen extends StatefulWidget {

  @override
  State<imagenScreen> createState() => _imagenScreenState();
}

class _imagenScreenState extends State<imagenScreen> {
  List<Widget> imageList = [];

  @override
  Widget build(BuildContext context) {
    imageList = [
      ButtonImage(name: "Mercado", img: "market_icon.png"),
      ButtonImage(name: "Metro", img: "subway_icon.png"),
      ButtonImage(name: "Metro", img: "subway_icon.png"),
      ButtonImage(name: "Ayuda", img: "help_icon.png"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "IMÁGENES",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Lista:",
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: imageList,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return IconWindow();
                    },
                  );
                },
                child: Text('Añadir Nuevo')
            ),
          ],
        ),
      ),
    );
  }
}

/*
Widget _buttonImage(BuildContext context,String name, String img) {
  return InkWell(
    onTap: () {
      // Acción a realizar al hacer clic en el botón de imagen
      Navigator.push(context, MaterialPageRoute(builder: (_)=>cardScreen(selectedImage: img, name: name,)));
      print('Has hecho clic en la imagen: $img');
    },
    child: Container(
      width: 180,
      height: 200,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0), // Agregar margen a todas las direcciones
          child: Column(
            children: [
              Image.asset(
                "assets/" + img,
                width: 145,
              ),
              SizedBox(height: 8), // Agregar espacio vertical entre la imagen y el texto
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


class _imagenScreenState extends State<imagenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "IMÁGENES",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(20.0),
                  child: Text("Lista:", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buttonImage("Mercado","market_icon.png"),
                _buttonImage("Metro", "subway_icon.png"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buttonImage(String name, String img) {
  return InkWell(
    child: Container(
      width: 180,
      height: 200,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0), // Agregar margen a todas las direcciones
          child: Column(
            children: [
              Image.asset(
                "assets/" + img,
                width: 145,
              ),
              SizedBox(height: 8), // Agregar espacio vertical entre la imagen y el texto
              Text(name),
            ],
          ),
        ),
      ),
    ),
  );
}*/
