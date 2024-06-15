import 'package:application_alpha/classes/imagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:application_alpha/imageRequest.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../sharedPreferencesHelper.dart';

class newImageScreen extends StatefulWidget {
  const newImageScreen({super.key});

  @override
  State<newImageScreen> createState() => _newImageScreenState();
}

class _newImageScreenState extends State<newImageScreen> {
  String userInput = '';
  String? svgData; // Variable para almacenar el SVG recibido
  List<String> svgList = [];

  Future<void> _loadSVGs(String word) async {
    try {
      // Llama a la función fetchSVGs para obtener los 6 SVG y los almacena en la lista svgList
      svgList.clear(); // Limpia la lista antes de agregar los nuevos SVG
      final svgs = await fetchSVGs(word);
      svgList.addAll(svgs);
      setState(() {}); // Actualiza el estado para reflejar los SVG recibidos
    } catch (e) {
      print('Error cargando SVGs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear nuevo botón',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          // Campo de texto
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Escribe una palabra',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0), // Radio de borde redondeado
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkResponse(
                  onTap: () {
                    _loadSVGs(userInput);
                    print('Texto enviado: $userInput');
                  },
                  borderRadius: BorderRadius.circular(30), // Radio de borde del área sensible
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green, // Color de fondo del botón
                    ),
                    child: const Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.white, // Color del ícono
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Mostrar el SVG recibido
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de columnas en la cuadrícula
              ),
              itemCount: svgList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    // Selección del ícono aquí
                    print('Ícono seleccionado: $index');

                    // Muestra un diálogo para que el usuario ingrese el nombre
                    final result = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        String? nameInput;
                        return AlertDialog(
                          title: const Text('Guardar'),
                          content: TextField(
                            onChanged: (value) {
                              nameInput = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Ingresa el nombre',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.pink, // Color de fondo del botón Guardar
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(nameInput ?? userInput);
                              },
                              child: const Text(
                                  'Guardar',
                                  style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.cyan, // Color de fondo para Borrar Módulo
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (result != null) {
                      await SharedPreferencesHelper.saveSVG('svg_and_name', result, svgList[index]);
                      //print('SVG guardado con el nombre: $result');

                      // Navegar a la pantalla ImageScreen después de guardar el SVG
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => imagenScreen()),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54, // Color del borde
                          width: 2.5, // Grosor del borde
                        ),
                      ),
                      child: svgList[index] != null
                          ? SvgPicture.string(
                        svgList[index],
                        width: 100,
                        height: 100,
                      )
                          : CircularProgressIndicator(), // Muestra un círculo de carga si el SVG aún no se ha cargado
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
