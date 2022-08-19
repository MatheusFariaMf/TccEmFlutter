import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_images.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';

class ItemListas extends StatefulWidget {
  final String nomeItem;
  final double paddingLeft;

  const ItemListas({
    Key? key,
    required this.nomeItem,
    required this.paddingLeft,
  }) : super(key: key);

  @override
  _ItemListasState createState() => _ItemListasState();
}

class _ItemListasState extends State<ItemListas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.shape,
        //border: Border(bottom: BorderSide(color: AppColors.stroke, width: 1)),
      ),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: widget.paddingLeft, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.nomeItem,
                  style: TextStyles.itensMenu,
                ),
                InkWell(
                  onTap: () => {funcao(context)},
                  child: Image.asset(
                    AppImages.hamburguer,
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Future funcao(BuildContext context) {
  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    fixedSize: Size(230, 45),
    primary: AppColors.primary,
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 350,
          width: 500,
          child: Stack(
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
