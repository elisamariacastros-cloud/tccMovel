import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/telas/Splash2.dart';
import 'package:login/visao/estilos/EstilosBotoes.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/telas/Principal.dart';
import 'package:login/visao/util/WidgetsUteis.dart';
import 'package:login/modelo/Objects/autorizacao.dart';
import 'package:login/modelo/local_storage_service.dart';
import 'package:login/modelo/auth_service.dart';
import 'package:login/modelo/aluno_service.dart';


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

    final resultadoLogin = await AuthService().login(email, senha);

    if (resultadoLogin['sucesso']) {
      await LocalStorageService.salvarAutorizacao(resultadoLogin['autorizacao']);

      // busca os dados do aluno e já salva localmente
      final aluno = await AlunoService().buscarMeusDados(
        resultadoLogin['autorizacao'].token_autorizacao,
      );

      if (aluno != null) {
        await LocalStorageService.salvarAluno(aluno);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, $email!')),
      );
      telaSplash2(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultadoLogin['mensagem'])),
      );
    }
  }

  void telaSplash2(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Splash2()),
    );
  }

  Widget _showEntrar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          style: TextStyle(color: Theme.of(context).primaryColorDark),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: Internacionalizacao.hintTextEmail,
            hintStyle: EstilosTextosCustomizado.formField(context),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.0)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.0)),
            prefixIcon:
            const Icon(Icons.email, color: Color.fromARGB(255, 170, 0, 0)),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          obscureText: true,
          style: TextStyle(color: Theme.of(context).primaryColor),
          controller: _passwordController,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _enviarFormulario(),
          decoration: InputDecoration(
            hintText: Internacionalizacao.hintTextPassword,
            hintStyle: EstilosTextosCustomizado.formField(context),
            enabledBorder: UnderlineInputBorder(
                borderSide: EstilosBotoes().borderSideFino(context)),
            focusedBorder: UnderlineInputBorder(
                borderSide: EstilosBotoes().borderSideFino(context)),
            prefixIcon: const Icon(Icons.lock,
                color: Color.fromARGB(255, 170, 0, 0)),
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WidgetsUteis().botaoSemBorda(
              context: context, texto: 'ACESSAR', executa: _enviarFormulario),
        ),
      ],
    );
  }

  @override
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
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F5F5), Colors.white],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final minAltura =
              constraints.maxHeight > 48 ? constraints.maxHeight - 48 : 0.0;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minAltura),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            Internacionalizacao.logoTitle,
                            textAlign: TextAlign.center,
                            style: EstilosTextosCustomizado.title(context),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            Internacionalizacao.logoSubTitle,
                            textAlign: TextAlign.center,
                            style: EstilosTextosCustomizado.subTitle(context),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 234, 234),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(31, 116, 4, 4),
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
                ),
              );
            },
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