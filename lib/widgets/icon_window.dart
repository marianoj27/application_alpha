import 'package:flutter/material.dart';
import 'package:application_alpha/imageRequest.dart';

class IconWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Seleccione un icono'),
      children: <Widget>[
        SingleChildScrollView(
          child: Wrap(
            children: List<Widget>.generate(
              IconsData.iconList.length,
                  (index) {
                final selectedIcon = IconsData.iconList[index];
                return IconButton(
                  icon: Icon(selectedIcon),
                  onPressed: () {
                    final iconName = _getIconName(selectedIcon);
                    print('Icono seleccionado: $iconName');
                    Navigator.pop(context, iconName);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String _getIconName(IconData icon) {
    return icon.toString().substring(8); // Elimina 'MaterialIconData(' del nombre del icono
  }
}

class IconsData {
  static final List<IconData> iconList = [];
}
