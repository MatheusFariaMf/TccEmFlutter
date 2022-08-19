import 'package:flutter/material.dart';
import 'package:uai_pay/modules/cadastro_usuario/cadastro_usuario_page.dart';
import 'package:uai_pay/shared/themes/app_colors.dart';
import 'package:uai_pay/shared/themes/app_text_styles.dart';
import 'package:uai_pay/shared/themes/app_texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final largura_tela = MediaQuery.of(context).size.width;
    final altura_tela = MediaQuery.of(context).size.height;

    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: Size(largura_tela, 45),
      primary: AppColors.primary,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, altura_tela / 5, 16.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.payment,
                  color: AppColors.background,
                  size: 160,
                ),
              ),
              Text(
                GeneralsTexts.nome_app,
                style: TextStyles.titleHome,
              ),
              const SizedBox(height: 15),
              TextFormField(
                onChanged: (text) {
                  _email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: AppColors.primary),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                onChanged: (text) {
                  _password = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: AppColors.primary),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child: const Text('Fazer login'),
                style: style,
                onPressed: () {
                  //Navigator.pushNamed(context, "/home");
                  Navigator.pushReplacementNamed(context, "/home");
                  /*if (_email == "certo" && _password == "123") {
                    Navigator.pushNamed(context, "/home");
                    print("Email e senha corretos.");
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Erro!"),
                        content: const Text("E-mail e/ou senha inválidos."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Entendi"),
                          )
                        ],
                      ),
                    );
                  }*/
                },
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  print("Se precisar confirmar senha");
                  Navigator.pushNamed(context, "/cardapio");
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: (Text(
                    "Esqueci minha senha",
                    style: TextStyles.linksPequenos,
                  )),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Realizar cadastro'),
                style: style,
                onPressed: () {
                  Navigator.pushNamed(context, "/cadastro_usuario");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
