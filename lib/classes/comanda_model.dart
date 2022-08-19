import 'package:mobx/mobx.dart';
import 'package:uai_pay/classes/produto.dart';
part 'comanda_model.g.dart';

class ComandaModel = _ComandaModelBase with _$ComandaModel;

abstract class _ComandaModelBase with Store {
  final Produto produto;

  @observable
  int _quantidade = 1;

  @computed
  int get quantidade => _quantidade;

  _ComandaModelBase(this.produto);

  @action
  void adicionar() {
    _quantidade++;
  }

  @action
  void remover() {
    _quantidade--;
  }
}
