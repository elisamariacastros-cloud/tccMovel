import 'package:flutter/material.dart';

class IconeSocial extends StatelessWidget {
  final IconData iconData;
  //final VoidCallback onPressed; // Callback para interatividade

  IconeSocial(this.iconData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0), // Padding configurado claramente
      child: Container(
        width: 40.0,
        height: 40.0,
        child: RawMaterialButton(
          onPressed: () {}, //onPressed, // Função do botão
          shape: CircleBorder(),
          fillColor: const Color.fromARGB(
              255, 170, 0, 0), // Cor de fundo para destaque
          child: Icon(
            iconData,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
