import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
