import 'package:flutter/material.dart';
import 'package:uai_pay/classes/estabelecimento.dart';
import 'package:uai_pay/modules/home/leitor_qrcode.dart';
import 'package:uai_pay/modules/home/pesquisa_menu.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/widgets/item_listas_preco/item_listas_preco.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _resultadoLeitura;
  final leitorQR = LeitorQrCode();
  final pesquisaMenu = PesquisaMenu();

  buscaMenu(BuildContext context) async {
    /*String response = await leitorQR.lerQRCode();
    setState(() {
      _resultadoLeitura = response;
    });

    String respostaMenu = await pesquisaMenu.pesquisaLocal(response); */

    Estabelecimento? estabelecimento =
        await pesquisaMenu.pesquisaLocal("qualquer coisa");

    if (estabelecimento == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Tempo estourado"),
          );
        },
      );
    } else {
      //print(respostaMenu);
      print(estabelecimento.Menu[0].codigoCategoria);
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width - 32;

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: Size(larguraTela, 45),
      primary: AppColors.secundary,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar da página Home"),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => {buscaMenu(context)},
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code,
                        color: AppColors.background,
                        size: 80,
                      ),
                      Text(
                        "Ler QR code",
                        style: TextStyles.buttonBackground,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/cardapio");
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColors.secundary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_alt,
                        color: AppColors.background,
                        size: 80,
                      ),
                      Text(
                        "Cardápio",
                        style: TextStyles.buttonBackground,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/pedidos_abertos");
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColors.secundary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_alt,
                        color: AppColors.background,
                        size: 80,
                      ),
                      Text(
                        "Pedidos Abertos",
                        style: TextStyles.buttonBackground,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: AppColors.background,
                      size: 80,
                    ),
                    Text(
                      "Pedidos Encerrados",
                      style: TextStyles.buttonBackground,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
