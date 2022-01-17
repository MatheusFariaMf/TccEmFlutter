import 'package:flutter/material.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: widget.paddingLeft),
                child: Text(
                  widget.nomeItem,
                  style: TextStyles.itensMenu,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
