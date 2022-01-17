import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/widgets/item_listas/item_listas.dart';

class FormasPagamento extends StatefulWidget {
  const FormasPagamento({Key? key}) : super(key: key);

  @override
  _FormasPagamentoState createState() => _FormasPagamentoState();
}

class _FormasPagamentoState extends State<FormasPagamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: const [
          ItemListas(nomeItem: "PIX", paddingLeft: 8.0),
          ItemListas(nomeItem: "CARTÃO DE CRÉDITO", paddingLeft: 8.0),
          ItemListas(nomeItem: "CARTÃO DE DÉBITO", paddingLeft: 8.0),
          ItemListas(nomeItem: "AME", paddingLeft: 8.0),
          ItemListas(nomeItem: "MERCADO PAGO", paddingLeft: 8.0),
          ItemListas(nomeItem: "PICPAY", paddingLeft: 8.0),
        ],
      ),
    );
  }
}
