import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class imageRequest extends StatefulWidget {
  const imageRequest({super.key});

  @override
  State<imageRequest> createState() => _imageScreenState();
}

class _imageScreenState extends State<imageRequest> {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(

        appBar: AppBar(

          title: Text('Flutter HTTP Example'),

        ),

        body: Center(

          child: FutureBuilder<String>(

            future: fetchSVG(),

            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {

                return CircularProgressIndicator();

              } else if (snapshot.hasError) {

                return Text('Error: ${snapshot.error}');

              } else {

                return snapshot.hasData

                    ? Text(snapshot.data!)

                    : Text('No SVG found');

              }

            },

          ),

        ),

      ),

    );

  }


  Future<String> fetchSVG() async {

    const String url = "https://www.svgrepo.com/vectors/meal/";

    const String pattern = "https://www.svgrepo.com/show/";


    // First request

    final requestMeal = await http.get(Uri.parse(url));

    final pos1 = requestMeal.body.indexOf(pattern);

    final pos2 = requestMeal.body.indexOf('"', pos1);


    if (pos1 == -1 || pos2 == -1) {

      throw Exception('Pattern not found');

    }


    final finalURL = requestMeal.body.substring(pos1, pos2);


    // Second request

    final requestFirstImg = await http.get(Uri.parse(finalURL));

    final pos3 = requestFirstImg.body.indexOf("<svg");

    final pos4 = requestFirstImg.body.indexOf("svg>", pos3);


    if (pos3 == -1 || pos4 == -1) {

      throw Exception('SVG not found');

    }


    final finalSVG = requestFirstImg.body.substring(pos3, pos4 + 4);

    return finalSVG;

  }

}