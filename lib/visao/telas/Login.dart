import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/telas/Splash2.dart';
import 'package:login/visao/telas/TelaRecuperacaoSenha.dart';
import 'package:login/visao/estilos/EstilosBotoes.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/telas/Principal.dart';
import 'package:login/visao/util/WidgetsUteis.dart';
import 'package:login/modelo/Objects/autorizacao.dart';
import 'package:login/modelo/local_storage_service.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _enviarFormulario() async {
    String email = _emailController.text;
    String senha = _passwordController.text;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    Autorizacao? authSalvo = await LocalStorageService.carregarAutorizacao();

    if (authSalvo != null && authSalvo.usuario == email && authSalvo.senha == senha) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, $email!')),
      );
      telaSplash2(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado!!!')),
      );
    }
  }

  void telaSplash2(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Splash2()),
    );
  }

  void telaRecuperacaoSenha(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaRecuperacaoSenha()),
    );
  }

  Widget _showEntrar(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              style: TextStyle(color: Theme.of(context).primaryColorDark),
              controller: _emailController,
              decoration: InputDecoration(
                hintText: Internacionalizacao.hintTextEmail,
                hintStyle: EstilosTextosCustomizado.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.0)),
                prefixIcon: const Icon(Icons.email,
                    color: Color.fromARGB(255, 170, 0, 0)),
              ),
              obscureText: false,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(50),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Theme.of(context).primaryColor),
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: Internacionalizacao.hintTextPassword,
                hintStyle: EstilosTextosCustomizado.formField(context),
                enabledBorder: UnderlineInputBorder(
                    borderSide: EstilosBotoes().borderSideFino(context)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: EstilosBotoes().borderSideFino(context)),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color.fromARGB(255, 170, 0, 0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(80),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: WidgetsUteis().botaoSemBorda(
              context: context, texto: 'ACESSAR', executa: _enviarFormulario),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(15),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WidgetsUteis().horizontalLine(),
                Text('-', style: EstilosTextosCustomizado.body(context)),
                WidgetsUteis().horizontalLine()
              ],
            ),
          ),
        ),
        WidgetsUteis().espacoHorizontal15,
        WidgetsUteis().botao2SemBorda(
          context: context,
          texto: "Esqueci minha senha...",
          executa: () => telaRecuperacaoSenha(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F5F5),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Internacionalizacao.logoTitle,
                        style: EstilosTextosCustomizado.title(context),
                      ),
                      Text(
                        Internacionalizacao.logoSubTitle,
                        style: EstilosTextosCustomizado.subTitle(context),
                      ),
                    ],
                  ),
                ),
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setHeight(190),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(65),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 250),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 234, 234),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(31, 116, 4, 4),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: _showEntrar(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Internacionalizacao {
  static String logoTitle = "TREINO +";
  static String logoSubTitle = "SEU APP DE CONTROLE DE TREINOS";
  static String signInMenuButton = "ACESSAR";
  static String hintTextEmail = "Email";
  static String hintTextPassword = "Senha";
}