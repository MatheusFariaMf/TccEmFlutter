import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uai_pay/modules/cadastro_usuario/cadastro_usuario_page.dart';
import 'package:uai_pay/modules/cardapio/main_cardapio_page.dart';
import 'package:uai_pay/modules/formas_pagamento/formas_pagamento.dart';
import 'package:uai_pay/modules/login/login_page.dart';
import 'package:uai_pay/modules/pedidos_abertos/pedidos_abertos.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';

import 'modules/home/home_page.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Payflow',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: AppColors.primary,
          dividerColor: Colors.transparent,
        ),
        initialRoute: "/splash",
        routes: {
          "/splash": (context) => SplashPage(),
          "/home": (context) => HomePage(),
          "/login": (context) => LoginPage(),
          "/cadastro_usuario": (context) => CadastroUsuarioPage(),
          "/cardapio": (context) => MainCardapioPage(),
          "/formas_pagamento": (context) => FormasPagamento(),
          "/pedidos_abertos": (context) => PedidosAbertos(),
        });
  }
}
