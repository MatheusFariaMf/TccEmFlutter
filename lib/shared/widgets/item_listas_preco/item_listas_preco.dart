import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';

class ItemListasPreco extends StatelessWidget {
  final String nomeItem;
  final String precoItem;

  const ItemListasPreco(
      {Key? key, required this.nomeItem, required this.precoItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.shape,
        border: Border(
          bottom: BorderSide(color: AppColors.stroke, width: 1.0),
        ),
      ),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  nomeItem,
                  style: TextStyles.itensMenu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  precoItem,
                  style: TextStyles.itensMenuPrecos,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
