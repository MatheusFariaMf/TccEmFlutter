import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:uai_pay/classes/categoria.dart';
import 'dart:convert' as convert;

import 'package:uai_pay/classes/estabelecimento.dart';
import 'package:uai_pay/classes/produto.dart';

class PesquisaMenu {
  Future<Estabelecimento?> pesquisaLocal(String ip_busca) async {
    try {
      print(
          "---- - - - -- - - -- - -- - ---AAAAAAAAAAAAAA CHEGOU AQUI. Essa é a resposta recebida: $ip_busca");

      var url = Uri.http('192.168.0.101:21262', '');

      var response = await http.get(url).timeout(const Duration(seconds: 3));

      var jsonResponse = convert.jsonDecode(response.body);

      //criação da variável menu da propriedade menu de estabelecimento
      List<Categoria> menu = List.empty(growable: true);

      for (var categ in jsonResponse['Menu']) {
        //para cada categoria de produtos do menu, há uma nova lista de produtos
        List<Produto> produtos = List.empty(growable: true);
        //'for' responsável por preencher a lista de produtos de cada cateoria
        for (var prod in categ['Itens']) {
          Produto produto = Produto(
            prod['CodigoProduto'],
            prod['NomeItem'],
            prod['Preco'],
            prod['LinkImagem'],
            prod['Observacao'],
            prod['Quantidade'],
            prod['Unidade'],
          );
          //adiciona o produto na lista de produtos específica de cada categoria
          produtos.add(produto);
        }

        //após a adição de todos os produtos da respectiva categoria, adiciona o array de produtos na categoria
        Categoria categoria = Categoria(
          categ['CodigoCategoria'],
          categ['NomeCategoria'],
          produtos,
        );

        //adição da categoria ao menu
        menu.add(categoria);

        //finalização do 'for', onde o loop irá se repetir para cada categoria dentro do mesmo menu
      }
      //após finalizar o menu, cria finalmente o objeto do estabelecimento que recebe o menu montado
      Estabelecimento estabelecimento = Estabelecimento(
        jsonResponse['CodigoEstabelecimento'],
        jsonResponse['TipoEstabelecimento'],
        jsonResponse['DescricaoTipo'],
        jsonResponse['NomeEstabelecimento'],
        jsonResponse['Rua'],
        jsonResponse['Numero'],
        jsonResponse['Complemento'],
        jsonResponse['Bairro'],
        jsonResponse['Cidade'],
        jsonResponse['Estado'],
        jsonResponse['CEP'],
        menu,
      );

      for (var item in menu[0].Itens) {
        print(
            "Codigo dos produtos da primeira categoria: ${item.CodigoProduto}");
      }
      for (var item in menu[1].Itens) {
        print(
            "Codigo dos produtos da segunda categoria: ${item.CodigoProduto}");
      }

      print(estabelecimento.codigoEstabelecimento);

      /* print(" - -- - - -- - Resposta inteira:   $jsonResponse");
      print(jsonResponse['CodigoEstabelecimento']);
      print(jsonResponse['TipoEstabelecimento']);
      print(jsonResponse['NomeEstabelecimento']);
      print(jsonResponse['Rua']);
      print(jsonResponse['Numero']);
      print(jsonResponse['NomeEstabelecimento']); */

      //print(jsonResponse['Menu']);
      //print(" - -- Resposta inteira - - - - - -: " +
      // jsonResponse['CodigoEstabelecimento']);

      //--------------- QUANDO O RETORNO É UM USUÁRIO DA API FAKE -------------
      //print(jsonResponse[0]['1']['Nome']);
      //List<dynamic> user = convert.jsonDecode(response.body);
      //print('Howdy, ${user[0]}!');

      return estabelecimento;
      //print('We sent the verification link to ${user['email']}.');
    } on TimeoutException catch (error) {
      print("Erro de timout: $error");

      return null;
    } catch (e) {
      print("Erro na pesquisa da API: $e");
      return null;
    }
  }
}
