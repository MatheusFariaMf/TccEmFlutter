import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:uai_pay/classes/comanda_model.dart';
import 'package:uai_pay/shared/stores/comanda_store.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_images.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ComandaPage extends StatefulWidget {
  const ComandaPage({Key? key}) : super(key: key);

  @override
  State<ComandaPage> createState() => _ComandaPageState();
}

class _ComandaPageState extends State<ComandaPage> {
  double total = 0;
  bool chamouCallback = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        //total = totalParcial;
        chamouCallback = true;
      }),
    );
  }

  void setaValorTotal(ComandaStore comandaStore) {
    // Define o valor total dos produtos
    double totalParcial = 0;
    for (var element in comandaStore.produtosNaComanda) {
      totalParcial += element.produto.Preco * element.quantidade;
    }
    setState(() {
      total = totalParcial;
    });
  }

  void pagaComanda(ComandaStore comandaStore) async {
    ObservableList<ComandaModel> produtosComanda =
        comandaStore.produtosNaComanda;
    String nomesProdutos = "";
    String observacoesProdutos = "";
    String precosProdutos = "";
    String quantidadesProdutos = "";
    // Além de fazer a concatenação de todos os valores dos produtos em strings, se for o último produto da lista, não coloca vírgula após
    for (int u = 0; u < produtosComanda.length; u++) {
      if (u != produtosComanda.length - 1) {
        nomesProdutos += produtosComanda[u].produto.NomeItem + ',';
        observacoesProdutos += produtosComanda[u].produto.Observacao + ',';
        precosProdutos +=
            produtosComanda[u].produto.Preco.toStringAsFixed(2) + ',';
        quantidadesProdutos += produtosComanda[u].quantidade.toString() + ',';
      } else {
        nomesProdutos += produtosComanda[u].produto.NomeItem;
        observacoesProdutos += produtosComanda[u].produto.Observacao;
        precosProdutos += produtosComanda[u].produto.Preco.toStringAsFixed(2);
        quantidadesProdutos += produtosComanda[u].quantidade.toString();
      }
    }
    // Cria um Map<string,string> para mandar ao servidor como body da requisição
    final preferences = {
      'title': nomesProdutos,
      'description': observacoesProdutos,
      'unit_price': precosProdutos,
      'quantity': quantidadesProdutos,
    };

    var urlMercadoPago = Uri.http('192.168.0.110:21262', 'preferencias');
    var response = await http
        .post(urlMercadoPago, body: preferences)
        .timeout(const Duration(seconds: 4));

    var jsonResponse = convert.jsonDecode(response.body);
    var preferenceId = jsonResponse['id'];

    //print("Preference ID: $idDaPreferencia");
    print("Preference ID depois do jsonDecode: $preferenceId");

    PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
      "TEST-346ce398-ecbe-4f85-b040-b09fcf539470",
      preferenceId,
    );
    print("RESULT.TOSTRING: " + result.toString());
    print("RESULT.RESULT: " + result.result);
  }

  @override
  Widget build(BuildContext context) {
    final comandaStore = context.watch<ComandaStore>();
    setaValorTotal(comandaStore);
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: Size(MediaQuery.of(context).size.width, 45),
      primary: AppColors.primary,
    );

    print("quantidade na comanda: " +
        comandaStore.produtosNaComanda.length.toString());

    if (comandaStore.produtosNaComanda.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text("Comanda"),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "A comanda está vazia",
                    style: TextStyles.carrinhoVazio,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text("Comanda"),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 600,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: comandaStore.produtosNaComanda.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comandaStore.produtosNaComanda[index].produto
                                      .NomeItem,
                                ),
                                Text("R\$" +
                                    comandaStore
                                        .produtosNaComanda[index].produto.preco
                                        .toStringAsFixed(2)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      leading: Image.asset(
                        AppImages.hamburguer,
                        width: 60,
                        height: 60,
                      ),
                      trailing: Text(
                        "Qtde. " +
                            comandaStore.produtosNaComanda[index].quantidade
                                .toString(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL", style: TextStyles.valorTotal),
                  Text(
                    "R\$" + "${total.toStringAsFixed(2)}",
                    style: TextStyles.valorTotal,
                  ),
                ],
              ),
            ),
            //Text('Running on: $_platformVersion\n'),
            ElevatedButton(
              onPressed: () => pagaComanda(comandaStore),
              child: Text("Pagar"),
            ),
          ],
        ),
      );
    }
  }
}
