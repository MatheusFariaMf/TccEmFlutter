import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LeitorQrCode {
  Future<String> lerQRCode() async {
    try {
      String codigo = "";
      String leitura = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF",
        "Cancelar",
        true,
        ScanMode.QR,
      );

      codigo = leitura != "-1" ? leitura : "Código inválido";

      print("variavel leitura: $leitura");

      return codigo;
    } catch (e) {
      print("Erro na leitura do QR code: $e");
      throw Exception('Erro na leitura do QR code: $e');
    }
  }
}
