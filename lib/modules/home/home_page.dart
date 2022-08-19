import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uai_pay/classes/estabelecimento.dart';
import 'package:uai_pay/modules/home/info_devs_page.dart';
import 'package:uai_pay/modules/home/leitor_qrcode.dart';
import 'package:uai_pay/modules/home/pesquisa_menu.dart';
import 'package:uai_pay/shared/stores/estabelecimento_store.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final leitorQR = LeitorQrCode();
  final pesquisaMenu = PesquisaMenu();
  late EstabelecimentoStore estabelecimentoStore;

  // Busca o cardápio do restaurante pela leitura do QRCode
  buscaMenu(BuildContext context) async {
    // RESPONSÁVEL PELA LEITURA DO QR CODE
    String response = await leitorQR.lerQRCode();

    Estabelecimento? respostaMenu = await pesquisaMenu.pesquisaLocal(response);
    if (respostaMenu != null) {
      estabelecimentoStore.setEstabelecimento(respostaMenu);
    }

    if (estabelecimentoStore.estabelecimento != null && respostaMenu == null) {
      confereLeituraQRCode("Leitura QrCode", true);
    } else if (estabelecimentoStore.estabelecimento != null &&
        respostaMenu != null) {
      confereLeituraQRCode("Leitura QrCode", false);
    }
  }

  // Função que confere se já um estabelecimento pesquisado pelo QRCode
  confereLeituraQRCode(String localDaChamada, bool leitorCancelado) {
    if (localDaChamada == "Leitura QrCode") {
      if (estabelecimentoStore.estabelecimento == null) {
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
      } else if (estabelecimentoStore.estabelecimento!.CodigoEstabelecimento ==
          0000) {
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
      } else if (!leitorCancelado) {
        Navigator.pushNamed(
          context,
          "/cardapio",
          arguments: {
            'estabelecimentoAtual': estabelecimentoStore.estabelecimento
          },
        );
      }
    } else if (localDaChamada == "Cardapio") {
      if (estabelecimentoStore.estabelecimento == null ||
          estabelecimentoStore.estabelecimento!.CodigoEstabelecimento == 0000) {
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
          arguments: {
            'estabelecimentoAtual': estabelecimentoStore.estabelecimento
          },
        );
      }
    }
  }

  mostraLogoRestaurante() {
    if ((estabelecimentoStore.estabelecimento == null ||
        estabelecimentoStore.estabelecimento!.CodigoEstabelecimento == 0000)) {
      return const Text("");
    } else {
      return Image.network(
        "https://ronepage.com.br/api/${estabelecimentoStore.estabelecimento!.logo}",
        width: 150,
        height: 150,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtem o store global da aplicacao para o estabelecimento
    estabelecimentoStore = context.watch<EstabelecimentoStore>();
    final larguraTela = MediaQuery.of(context).size.width - 32;
    InfoDevs infoDevs = InfoDevs();

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: Size(larguraTela, 45),
      primary: AppColors.secundary,
    );

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("UaiPay"),
          backgroundColor: AppColors.primary,
          actions: [
            IconButton(
              color: AppColors.iconeInfo,
              splashColor: Colors.white,
              splashRadius: 20,
              icon: Icon(
                Icons.info,
                size: 30,
                //color: AppColors.iconeInfo,
              ),
              tooltip: 'Informação sobre os desenvolvedores',
              onPressed: () {
                setState(() {
                  infoDevs.abreModalInfos(context);
                });
              },
            ),
          ]),
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [mostraLogoRestaurante()],
          ),
          const SizedBox(height: 30),
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
                  confereLeituraQRCode("Cardapio", false);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/comanda");
        },
        backgroundColor: AppColors.primary,
        tooltip: 'Comanda',
        child: Icon(
          Icons.list_alt_rounded,
          color: AppColors.background,
        ),
      ),
    );
  }
}
