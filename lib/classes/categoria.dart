import 'package:uai_pay/classes/produto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoria.g.dart';

@JsonSerializable()
class Categoria {
  int codigoCategoria;
  String nomeCategoria;
  List<Produto> itens;

  Categoria(
    this.codigoCategoria,
    this.nomeCategoria,
    this.itens,
  );

  factory Categoria.fromJson(Map<String, dynamic> json) =>
      _$CategoriaFromJson(json);
  toJson() => _$CategoriaToJson(this);

  int get CodigoCategoria => codigoCategoria;

  String get NomeCategoria => nomeCategoria;

  List<Produto> get Itens => itens;
}
