import 'package:json_annotation/json_annotation.dart';

part 'produto.g.dart';

@JsonSerializable()
class Produto {
  int codigoProduto;
  String nomeItem;
  double preco;
  String linkImagem;
  String observacao;
  int quantidade;
  String unidade;

  Produto(
    this.codigoProduto,
    this.nomeItem,
    this.preco,
    this.linkImagem,
    this.observacao,
    this.quantidade,
    this.unidade,
  );

  factory Produto.fromJson(Map<String, dynamic> json) =>
      _$ProdutoFromJson(json);
  toJson() => _$ProdutoToJson(this);

  int get CodigoProduto => codigoProduto;

  String get NomeItem => nomeItem;

  double get Preco => preco;

  String get LinkImagem => linkImagem;

  String get Observacao => observacao;

  int get Quantidade => quantidade;

  String get Unidade => unidade;
}
