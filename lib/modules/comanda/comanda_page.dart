import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  double totalParcial = 0;
  bool chamouCallback = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          total = totalParcial;
          chamouCallback = true;
        }));
  }

  void pagaComanda() async {
    final preferences = {
      'items': [
        {
          'title': 'Meu produto',
          'description': 'Descrição do produto',
          'unit_price': 100.00,
          'quantity': 1,
        }
      ],
      'payer': {'email': 'emailteste@email.com'}
    };

    var algo = {
      'title': 'Meu produto',
      'description': 'Descrição do produto',
      'unit_price': '100.00',
      'quantity': '1',
    };

    String jsonString = convert.jsonEncode(algo); // encode map to json
    print(jsonString);

    var urlMercadoPago = Uri.http('192.168.0.107:21262', 'preferencias');
    var response = await http
        .post(urlMercadoPago, body: algo)
        .timeout(const Duration(seconds: 4));

    var jsonResponse = convert.jsonDecode(response.body);
    var preferenceId = jsonResponse['id'];

    //print("Preference ID: $idDaPreferencia");
    /*print("Preference ID depois do jsonDecode: $preferenceId");

    PaymentResult result = await MercadoPagoMobileCheckout.startCheckout(
      "TEST-346ce398-ecbe-4f85-b040-b09fcf539470",
      preferenceId,
    );
    print("RESULT.TOSTRING: " + result.toString());
    print("RESULT.RESULT: " + result.result);*/
  }

  @override
  Widget build(BuildContext context) {
    final comandaStore = context.watch<ComandaStore>();
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
                  totalParcial +=
                      comandaStore.produtosNaComanda[index].produto.preco *
                          comandaStore.produtosNaComanda[index].quantidade;
                  print(total);
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
              onPressed: pagaComanda,
              child: Text("Pagar"),
            ),
          ],
        ),
      );
    }
  }
}
