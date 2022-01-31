import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_images.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/widgets/item_listas/item_listas.dart';

class MainCardapioPage extends StatefulWidget {
  const MainCardapioPage({Key? key}) : super(key: key);

  @override
  _MainCardapioPageState createState() => _MainCardapioPageState();
}

class _MainCardapioPageState extends State<MainCardapioPage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: Size(230, 45),
      primary: AppColors.primary,
    );

    Future funcao() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 350,
              width: 500,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  /*Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: CircleAvatar(
                                  child: Icon(Icons.close),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hamburguer normal",
                            style: TextStyles.titleBoldHeading,
                          ),
                          Image.asset(
                            AppImages.teste,
                            width: 230,
                            height: 230,
                          ),
                          SizedBox(
                            width: 230,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'R\$20,00',
                                    style: TextStyles.titleBoldHeading,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            child: const Text('Adicionar ao carrinho'),
                            style: style,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(children: [
            ExpansionTile(
              title: Text(
                "HAMBURGUERES ARTESANAIS",
                style: TextStyles.itensMenu,
              ),
              children: [
                ItemListas(nomeItem: "Cheese Bacon", paddingLeft: 40.0)
              ],
              backgroundColor: AppColors.shape,
              collapsedBackgroundColor: AppColors.shape,
              textColor: AppColors.heading,
              iconColor: AppColors.heading,
            ),
            ExpansionTile(
              title: Text(
                "PIZZAS",
                style: TextStyles.itensMenu,
              ),
              children: [
                ItemListas(nomeItem: "Bacon", paddingLeft: 40.0),
                ItemListas(nomeItem: "À Moda", paddingLeft: 40.0),
                ItemListas(nomeItem: "Portuguesa", paddingLeft: 40.0),
              ],
              backgroundColor: AppColors.shape,
              collapsedBackgroundColor: AppColors.shape,
              textColor: AppColors.heading,
              iconColor: AppColors.heading,
            ),
            ExpansionTile(
              title: Text(
                "PORÇÕES",
                style: TextStyles.itensMenu,
              ),
              children: [
                ItemListas(nomeItem: "Mandioca", paddingLeft: 40.0),
                ItemListas(
                    nomeItem: "Fritas com bacom e queijo", paddingLeft: 40.0),
              ],
              backgroundColor: AppColors.shape,
              collapsedBackgroundColor: AppColors.shape,
              textColor: AppColors.heading,
              iconColor: AppColors.heading,
            ),
            InkWell(
              onTap: () => {funcao()},
              child: Text(
                "         TESTE PopUp          ",
                style: TextStyles.itensMenu,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
