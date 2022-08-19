import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uai_pay/shared/stores/estabelecimento_store.dart';
import 'app_widget.dart';
import 'shared/stores/comanda_store.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ComandaStore>(
          create: (_) => ComandaStore(),
        ),
        Provider<EstabelecimentoStore>(
          create: (_) => EstabelecimentoStore(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWidget();
  }
}
