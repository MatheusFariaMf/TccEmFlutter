import 'package:mobx/mobx.dart';
import 'package:uai_pay/classes/estabelecimento.dart';

part 'estabelecimento_store.g.dart';

class EstabelecimentoStore = _EstabelecimentoStoreBase
    with _$EstabelecimentoStore;

abstract class _EstabelecimentoStoreBase with Store {
  @observable
  Estabelecimento? estabelecimento;

  @action
  void setEstabelecimento(Estabelecimento? local) {
    if (local != null) {
      estabelecimento = local;
    }
    // Para cada quantidade de item, é visto se esse item já existe na comanda ou não
  }
}
