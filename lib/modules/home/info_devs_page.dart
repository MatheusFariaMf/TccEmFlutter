import 'package:flutter/material.dart';

class InfoDevs {
// Abre o modal do produto que o cliente selecionar
  Future abreModalInfos(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              width: 500,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin libero justo, convallis ac ullamcorper et, bibendum euismod nunc. Phasellus ut mollis neque. Proin volutpat tincidunt arcu, nec porta felis fermentum in. Vestibulum laoreet neque non urna laoreet, sed tincidunt mauris lacinia. Maecenas ac urna quis felis finibus pellentesque. Donec at leo non tellus maximus sodales.",
              ),
            ),
          );
        });
  }
}
