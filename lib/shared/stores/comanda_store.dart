import 'package:mobx/mobx.dart';
import 'package:uai_pay/classes/comanda_model.dart';
import 'package:uai_pay/classes/produto.dart';
part 'comanda_store.g.dart';

class ComandaStore = _ComandaStoreBase with _$ComandaStore;

abstract class _ComandaStoreBase with Store {
  @observable
  var produtosNaComanda = ObservableList<ComandaModel>();

  @action
  void adicionarProdutoNaComanda(Produto produto, int quantidade) {
    // Para cada quantidade de item, é visto se esse item já existe na comanda ou não
    for (int i = 0; i < quantidade; i++) {
      var index = produtosNaComanda.indexWhere(
          (comanda) => comanda.produto.codigoProduto == produto.codigoProduto);

      if (index >= 0) {
        produtosNaComanda.elementAt(index).adicionar();
      } else {
        produtosNaComanda.add(ComandaModel(produto));
      }
    }

    for (var element in produtosNaComanda) {
      print(element.produto.nomeItem +
          "quantidade: " +
          element.quantidade.toString());
    }
  }
}
