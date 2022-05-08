import 'package:flutter/material.dart';
import 'package:uai_pay/classes/categoria.dart';
import 'package:uai_pay/classes/estabelecimento.dart';
import 'package:uai_pay/classes/produto.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_images.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/widgets/item_listas/item_listas.dart';

class MainCardapioPage extends StatefulWidget {
  final Estabelecimento estabelecimentoAtual;

  const MainCardapioPage({Key? key, required this.estabelecimentoAtual})
      : super(key: key);

  @override
  _MainCardapioPageState createState() => _MainCardapioPageState();
}

class _MainCardapioPageState extends State<MainCardapioPage> {
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: const Size(230, 45),
      primary: AppColors.primary);

  @override
  Widget build(BuildContext context) {
    List<Categoria> categorias = widget.estabelecimentoAtual.Menu;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cardapio"),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: ListView.builder(
        itemBuilder: (BuildContext context, int categoria) {
          return ExpansionTile(
            backgroundColor: AppColors.shape,
            collapsedBackgroundColor: AppColors.shape,
            textColor: AppColors.heading,
            iconColor: AppColors.heading,
            title: Text(
              categorias[categoria].NomeCategoria,
              style: TextStyles.itensMenu,
            ),
            children: [
              _mostraSubItens(categorias[categoria].Itens),
            ],
          );
        },
        itemCount: categorias.length,
      ),
    );
  }

  Widget _mostraSubItens(List<Produto> produtos) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: produtos.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Image.asset(
            AppImages.hamburguer,
            width: 60,
            height: 60,
          ),
          title: Text(produtos[index].NomeItem),
          trailing: Text("R\$" + produtos[index].preco.toString()),
          onTap: _mostraItemSelecionado,
        ),
      ),
    );
  }

  Future _mostraItemSelecionado() {
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
}
