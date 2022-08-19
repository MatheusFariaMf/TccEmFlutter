import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uai_pay/classes/comanda_model.dart';
import 'package:uai_pay/classes/categoria.dart';
import 'package:uai_pay/classes/estabelecimento.dart';
import 'package:uai_pay/classes/produto.dart';
import 'package:uai_pay/shared/stores/comanda_store.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_images.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/widgets/item_listas/item_listas.dart';
import 'package:quantity_input/quantity_input.dart';

class MainCardapioPage extends StatefulWidget {
  final Estabelecimento estabelecimentoAtual;

  const MainCardapioPage({Key? key, required this.estabelecimentoAtual})
      : super(key: key);

  @override
  _MainCardapioPageState createState() => _MainCardapioPageState();
}

class _MainCardapioPageState extends State<MainCardapioPage> {
  String _textoResposta = "";
  int _counter = 0;
  int _quantidadePedida = 1;

  void alteraTextoResposta(setState, String texto) {
    setState(() {
      _textoResposta = texto;
    });
  }

  void alteraQuantidade(setState, int quantidade) {
    setState(() {
      _quantidadePedida = quantidade;
    });
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    fixedSize: const Size(230, 45),
    primary: AppColors.primary,
  );

  @override
  Widget build(BuildContext context) {
    List<Categoria> categorias = widget.estabelecimentoAtual.Menu;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cardápio"),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Image.network(
                "https://ronepage.com.br/api/${widget.estabelecimentoAtual.logo}",
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
                width: 150,
                height: 150,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  backgroundColor: AppColors.shape,
                  collapsedBackgroundColor: AppColors.shape,
                  textColor: AppColors.heading,
                  iconColor: AppColors.heading,
                  title: Text(
                    categorias[index].NomeCategoria,
                    style: TextStyles.itensMenu,
                  ),
                  children: [
                    _mostraSubItens(categorias[index].Itens),
                  ],
                );
              },
              itemCount: categorias.length,
            ),
          ],
        ),
      ),
    );
  }

  // Mostra os "filhos"/produtos de cada categoria
  Widget _mostraSubItens(List<Produto> produtos) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: produtos.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Image.asset(AppImages.hamburguer, width: 50, height: 50),
          title: Text(produtos[index].NomeItem),
          trailing: Text("R\$" + produtos[index].preco.toStringAsFixed(2)),
          onTap: () => _mostraItemSelecionado(produtos[index]),
        ),
      ),
    );
  }

  // Abre o modal do produto que o cliente selecionar
  Future _mostraItemSelecionado(Produto produto) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Obtém a comanda do Provider
          final ComandaStore comandaStore = context.read<ComandaStore>();
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              content: SizedBox(
                height: 440,
                width: 500,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      right: -10.0,
                      top: -10.0,
                      child: InkWell(
                        child: const CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                        onTap: () {
                          // Retorna os valores default dos estados da tela
                          Navigator.pop(context);
                          alteraTextoResposta(
                            setState,
                            "",
                          );
                          alteraQuantidade(
                            setState,
                            1,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              produto.NomeItem,
                              style: TextStyles.titleBoldHeading,
                            ),
                            Image.asset(
                              AppImages.hamburguer,
                              width: 230,
                              height: 230,
                            ),
                            SizedBox(
                              width: 230,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "R\$" + produto.preco.toStringAsFixed(2),
                                      style: TextStyles.titleBoldHeading,
                                    ),
                                    QuantityInput(
                                      value: _quantidadePedida,
                                      acceptsNegatives: false,
                                      acceptsZero: false,
                                      minValue: 1,
                                      inputWidth: 50,
                                      onChanged: (value) {
                                        alteraQuantidade(
                                          setState,
                                          int.parse(
                                            value.replaceAll(',', ''),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                                child: const Text('Fazer pedido'),
                                style: style,
                                onPressed: () {
                                  if (_quantidadePedida == 0) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                            "Não é possível fazer um pedido com 0 na quantidade.",
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    comandaStore.adicionarProdutoNaComanda(
                                      produto,
                                      _quantidadePedida,
                                    );
                                    alteraTextoResposta(
                                      setState,
                                      "Pedido feito!",
                                    );
                                  }
                                }),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                '$_textoResposta',
                                style: TextStyles.titleBoldHeading,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
