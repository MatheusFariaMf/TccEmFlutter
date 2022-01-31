import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/widgets/item_listas_preco/item_listas_preco.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void pesquisa() async {
  var url = Uri.http('jsonplaceholder.typicode.com', '/todos/1');

  var response = await http.get(url);

  var jsonResponse = convert.jsonDecode(response.body);

  print(jsonResponse);
}

void pesquisa_local() async {
  var url = Uri.http('192.168.0.104:21262', '');

  var response = await http.get(url);

  var jsonResponse = convert.jsonDecode(response.body);

  print(jsonResponse);
  print(jsonResponse[0]['1']['Nome']);

  List<dynamic> user = convert.jsonDecode(response.body);

  print('Howdy, ${user[0]}!');
  //print('We sent the verification link to ${user['email']}.');
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                onTap: () {
                  Navigator.pushNamed(context, "/cardapio");
                },
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
                  //pesquisa();
                  //pesquisa_local();
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
