import 'package:application_alpha/classes/cardScreen.dart';
import 'package:application_alpha/classes/newImageScreen.dart';
import 'package:flutter/material.dart';

import '../sharedPreferencesHelper.dart';
import '../widgets/button_image.dart';
import '../widgets/icon_window.dart';

class imagenScreen extends StatefulWidget {

  @override
  State<imagenScreen> createState() => _imagenScreenState();
}

class _imagenScreenState extends State<imagenScreen> {
  List<Widget> imageList = [];

  @override
  void initState() {
    super.initState();
    initializeDefaultButtons();
    loadSavedSVGAndNames();
  }

  void initializeDefaultButtons() {
    imageList.addAll([
      const ButtonImage(name: "Mercado", img: "market_icon.png"),
      const ButtonImage(name: "Metro", img: "subway_icon.png"),
      const ButtonImage(name: "Metro", img: "subway_icon.png"),
      const ButtonImage(name: "Ayuda", img: "help_icon.png"),
    ]);
  }

  Future<void> loadSavedSVGAndNames() async {
    final svgAndNameList = await SharedPreferencesHelper.loadSVG('svg_and_name');
    if (svgAndNameList != null) {
      setState(() {
        imageList.addAll(svgAndNameList.map((item) {
          final name = item[0];
          final svg = item[1];
          return ButtonImage(name: name, img: svg);
        }).toList());
      });
    }
  }

  Future<void> deleteSVGAndName(String name) async {
    await SharedPreferencesHelper.removeSVGByName('svg_and_name', name);
    setState(() {
      imageList.removeWhere((widget) => (widget as ButtonImage).name == name);
    });
  }

  Future<void> deletePhrasesFromImage(String name) async {
    //phrasesList = await SharedPreferencesHelper.getList(name);
    await SharedPreferencesHelper.clearList(name);
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: imageList,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => newImageScreen()),
                      );
                    },
                    child: const Text('Añadir Nuevo'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String? nameToDelete = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          String name = "";
                          return AlertDialog(
                            title: const Text('Borrar SVG'),
                            content: TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Nombre del SVG a borrar',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(name);
                                },
                                child: const Text('Borrar'),
                              ),
                            ],
                          );
                        },
                      );

                      if (nameToDelete != null && nameToDelete.isNotEmpty) {
                        await deleteSVGAndName(nameToDelete);
                        await deletePhrasesFromImage(nameToDelete);
                      }
                    },
                    child: const Text('Borrar SVG'),
                  ),
                ],
              ),
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
