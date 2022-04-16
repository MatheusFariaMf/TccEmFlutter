import 'package:uai_pay/classes/produto.dart';

class Categoria {
  final int _CodigoCategoria;
  final String _NomeCategoria;
  final List<Produto> Itens;

  Categoria(
    this._CodigoCategoria,
    this._NomeCategoria,
    this.Itens,
  );

  int get codigoCategoria => _CodigoCategoria;
}
