import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LeitorQrCode extends StatefulWidget {
  const LeitorQrCode({Key? key}) : super(key: key);

  @override
  _LeitorQrCodeState createState() => _LeitorQrCodeState();
}

class _LeitorQrCodeState extends State<LeitorQrCode> {
  String m_codigo = "";
  String m_endereco = "";

  Future<String> lerQRCode() async {
    try {
      String leitura = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF",
        "Cancelar",
        true,
        ScanMode.QR,
      );

      setState(() {
        m_codigo = leitura != "-1" ? leitura : "Código inválido";
        m_endereco = leitura != "-1" ? leitura : "";
      });

      pesquisaLocal(m_endereco);

      return leitura;
    } catch (e) {
      print("Erro na leitura do QR code: $e");
      throw Exception('Erro na leitura do QR code: $e');
    }
  }

  pesquisaLocal(String teste) async {
    try {
      //var url = Uri.http('192.168.0.102:21262', '');

      var url = Uri.http(m_endereco, '');

      var response = await http.get(url);

      var jsonResponse = convert.jsonDecode(response.body);

      print(jsonResponse);
      print(jsonResponse[0]['1']['Nome']);

      List<dynamic> user = convert.jsonDecode(response.body);

      print('Howdy, ${user[0]}!');
      //print('We sent the verification link to ${user['email']}.');
    } catch (e) {
      print("Erro na pesquisa da API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    lerQRCode;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (m_codigo != "")
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Codigo lido: $m_codigo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ElevatedButton.icon(
                onPressed: lerQRCode, //pesquisaLocal ,
                icon: Icon(Icons.qr_code_scanner),
                label: Text("Leitura"))
          ],
        ),
      ),
    );
  }
}
