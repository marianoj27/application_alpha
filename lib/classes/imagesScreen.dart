import 'package:application_alpha/classes/cardScreen.dart';
import 'package:application_alpha/classes/newImageScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../sharedPreferencesHelper.dart';
import '../widgets/button_image.dart';
import '../widgets/icon_window.dart';

class imagenScreen extends StatefulWidget {

  @override
  State<imagenScreen> createState() => _imagenScreenState();
}

class _imagenScreenState extends State<imagenScreen> {
  List<Widget> imageList = [];
  List<Widget> addedImageList = [];

  @override
  void initState() {
    super.initState();
    initializeDefaultButtons();
    loadSavedSVGAndNames();
  }

  void initializeDefaultButtons() {
    imageList.addAll([
      const ButtonImage(name: "Mercado", img: "market_icon.png",),
      const ButtonImage(name: "Metro", img: "subway_icon.png"),
      const ButtonImage(name: "Bar/Cafetería", img: "cafeteria_icon.png"),
      const ButtonImage(name: "Ayuda", img: "help_icon.png"),
    ]);
  }

  Future<void> loadSavedSVGAndNames() async {
    final svgAndNameList = await SharedPreferencesHelper.loadSVG('svg_and_name');
    if (svgAndNameList != null) {
      setState(() {
        addedImageList.addAll(svgAndNameList.map((item) {
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
      addedImageList.removeWhere((widget) => (widget as ButtonImage).name == name);
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
          "¡Imágenes!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.greenAccent,
        elevation: 4,
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
                        children: [
                          ...imageList,
                          ...addedImageList,
                        ],
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
                  TextButton.icon(
                    onPressed: () async {
                      List<String> selectedNames = [];
                      bool isCanceled = false;

                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                title: const Text('Eliminar objetos de la lista:'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      ...addedImageList.map((widget) {
                                        final ButtonImage buttonImage = widget as ButtonImage;
                                        bool isSelected = selectedNames.contains(buttonImage.name);

                                        return ListTile(
                                          leading: buttonImage.img.startsWith('<svg')
                                              ? SvgPicture.string(
                                            buttonImage.img,
                                            width: 40,
                                            height: 40,
                                          )
                                              : Image.asset(
                                            "assets/${buttonImage.img}",
                                            width: 30,
                                            height: 30,
                                          ),
                                          title: Text(
                                            buttonImage.name,
                                            style: TextStyle(color: isSelected ? Colors.red : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedNames.remove(buttonImage.name);
                                                } else {
                                                  selectedNames.add(buttonImage.name);
                                                }
                                              });
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      isCanceled = true;
                                      Navigator.of(context).pop([]);
                                    },
                                    child: const Text('Cancelar'),
                                    style: TextButton.styleFrom(
                                      backgroundColor: isCanceled ? Colors.black : null,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop(selectedNames);
                                      for (String nameToDelete in selectedNames) {
                                        if (nameToDelete.isNotEmpty && !isCanceled) {
                                          await deleteSVGAndName(nameToDelete);
                                          await deletePhrasesFromImage(nameToDelete);
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'Borrar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.white), // Icono para Borrar Módulo
                    label: const Text(
                      'Borrar',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink, // Color de fondo para Borrar Módulo
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => newImageScreen()),
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.white, size: 30,), // Icono para Añadir Nuevo
                    label: const Text(
                      'Añadir Nuevo',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.cyan, // Color de fondo para Añadir Nuevo
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0,), // Ajustar el espaciado aquí
                    ),
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
