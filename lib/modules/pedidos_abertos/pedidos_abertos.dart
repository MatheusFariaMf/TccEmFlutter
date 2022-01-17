import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/widgets/item_listas_preco/item_listas_preco.dart';

class PedidosAbertos extends StatefulWidget {
  const PedidosAbertos({Key? key}) : super(key: key);

  @override
  _PedidosAbertosState createState() => _PedidosAbertosState();
}

class _PedidosAbertosState extends State<PedidosAbertos> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: Size(MediaQuery.of(context).size.width, 45),
      primary: AppColors.primary,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 450,
                  child: ListView(
                    children: [
                      ItemListasPreco(nomeItem: "Água", precoItem: "R\$4,00"),
                      ItemListasPreco(
                          nomeItem: "Coca-Cola", precoItem: "R\$6,00"),
                      ItemListasPreco(
                          nomeItem: "Hambúrguer", precoItem: "R\$15,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                      ItemListasPreco(nomeItem: "Pastel", precoItem: "R\$5,00"),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 80, left: 16, right: 16),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TOTAL", style: TextStyles.valorTotal),
                          Text(
                            "R\$ 100,00",
                            style: TextStyles.valorTotal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: const Text('Fazer pedido'),
                        style: style,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        child: const Text('Fazer pedido e pagar'),
                        style: style,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
