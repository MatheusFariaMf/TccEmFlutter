import 'package:uai_pay/classes/categoria.dart';
import 'package:json_annotation/json_annotation.dart';

part 'estabelecimento.g.dart';

@JsonSerializable()
class Estabelecimento {
  int codigoEstabelecimento;
  String tipoEstabelecimento;
  String descricaoTipo;
  String nomeEstabelecimento;
  String rua;
  int numero;
  String complemento;
  String bairro;
  String cidade;
  String estado;
  String cep;
  List<Categoria> menu;

  //Definição da função via construtor
  Estabelecimento(
    this.codigoEstabelecimento,
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

  factory Estabelecimento.fromJson(Map<String, dynamic> json) =>
      _$EstabelecimentoFromJson(json);
  toJson() => _$EstabelecimentoToJson(this);

  int get CodigoEstabelecimento => codigoEstabelecimento;

  String get TipoEstabelecimento => tipoEstabelecimento;

  String get DescricaoTipo => descricaoTipo;

  String get NomeEstabelecimento => nomeEstabelecimento;

  String get Rua => rua;

  int get Numero => numero;

  String get Complemento => complemento;

  String get Bairro => bairro;

  String get Cidade => cidade;

  String get Estado => estado;

  String get Cep => cep;

  List<Categoria> get Menu => menu;
}

/* 
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

  factory Estabelecimento.fromJson(Map<String, dynamic> json) =>
      _$EstabelecimentoFromJson(json);
  toJson() => _$EstabelecimentoToJson(this);

  List<Categoria> get Menu => menu;
} */
