import 'package:flutter/material.dart';
import 'package:uai_pay/classes/estabelecimento.dart';
import 'package:uai_pay/modules/home/leitor_qrcode.dart';
import 'package:uai_pay/modules/home/pesquisa_menu.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Estabelecimento? estabelecimento;
  final leitorQR = LeitorQrCode();
  final pesquisaMenu = PesquisaMenu();

  buscaMenu(BuildContext context) async {
    Estabelecimento? procuraEstabelecimento =
        await pesquisaMenu.pesquisaLocal("qualquer coisa");
    setState(() {
      estabelecimento = procuraEstabelecimento;
    });

    confereLeituraQRCode("Leitura QrCode");
  }

  confereLeituraQRCode(String localDaChamada) {
    if (localDaChamada == "Leitura QrCode") {
      if (estabelecimento == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(
                "Erro indevido na busca do cardápio.",
              ),
            );
          },
        );
      } else if (estabelecimento!.CodigoEstabelecimento == 0000) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(
                "Tempo de busca acima da média. Tente ler o QR Code novamente.",
              ),
            );
          },
        );
      } else {
        Navigator.pushNamed(
          context,
          "/cardapio",
          arguments: {'estabelecimentoAtual': estabelecimento},
        );
      }
    } else if (localDaChamada == "Cardapio") {
      if (estabelecimento == null ||
          estabelecimento!.CodigoEstabelecimento == 0000) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Aviso!"),
              content: Text("Leia o QRCode antes de acessar ao cardápio."),
            );
          },
        );
        return;
      } else {
        Navigator.pushNamed(
          context,
          "/cardapio",
          arguments: {'estabelecimentoAtual': estabelecimento},
        );
      }
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
        centerTitle: true,
        title: Text("HOME"),
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
                  confereLeituraQRCode("Cardapio");
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
