import 'package:uai_pay/classes/categoria.dart';

class Estabelecimento {
  final int _codigoEstabelecimento;
  final String tipoEstabelecimento;
  final String descricaoTipo;
  final String nomeEstabelecimento;
  final String rua;
  final int numero;
  final String complemento;
  final String bairro;
  final String cidade;
  final String estado;
  final String cep;
  final List<Categoria> menu;

  //Definição da função via construtor
  Estabelecimento(
    this._codigoEstabelecimento,
    this.tipoEstabelecimento,
    this.descricaoTipo,
    this.nomeEstabelecimento,
    this.rua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.menu,
  );

  //Definição de função via getter
  int get codigoEstabelecimento => _codigoEstabelecimento;

  List<Categoria> get Menu => menu;
}
