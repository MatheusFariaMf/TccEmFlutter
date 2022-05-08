import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:uai_pay/classes/estabelecimento.dart';

class PesquisaMenu {
  Future<Estabelecimento?> pesquisaLocal(String ip_busca) async {
    try {
      print("---- - - - -- CHEGOU AQUI. Essa é a resposta recebida: $ip_busca");

      var url = Uri.http('192.168.0.103:21262', '');

      var menu = await http.get(url).timeout(const Duration(seconds: 3));

      var jsonMenu = convert.jsonDecode(menu.body);

      var estabelecimento = Estabelecimento.fromJson(jsonMenu);

      return estabelecimento;
    } on TimeoutException catch (error) {
      print("Erro de timout: $error");
      Estabelecimento estabelecimentoVazio =
          Estabelecimento(0000, "", "", "", "", 0, "", "", "", "", "", []);

      return estabelecimentoVazio;
    } catch (e) {
      print("Erro na pesquisa da API: $e");
      return null;
    }
  }
}
