import 'package:flutter/material.dart';
import 'package:application_alpha/classes/cardScreen.dart';

class ButtonImage extends StatelessWidget {
  final String name;
  final String img;

  const ButtonImage({
    Key? key,
    required this.name,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => cardScreen(selectedImage: img, name: name)),
        );
        print('Has hecho clic en la imagen: $img');
      },
      child: Container(
        width: 180,
        height: 200,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/" + img,
                  width: 145,
                ),
                SizedBox(height: 8),
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
}
