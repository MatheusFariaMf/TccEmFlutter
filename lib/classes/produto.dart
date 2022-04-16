class Produto {
  final int _CodigoProduto;
  final String _NomeItem;
  final double _Preco;
  final String _LinkImagem;
  final String _Observacao;
  final int _Quantidade;
  final String _Unidade;

  Produto(
    this._CodigoProduto,
    this._NomeItem,
    this._Preco,
    this._LinkImagem,
    this._Observacao,
    this._Quantidade,
    this._Unidade,
  );

  int get CodigoProduto => _CodigoProduto;
}
