import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/modelo/local_storage_service.dart';
import 'package:login/modelo/Objects/autorizacao.dart';

class TelaDadosPessoais extends StatefulWidget {
  const TelaDadosPessoais({super.key, required this.title});

  final String title;

  @protected
  @override
  State<TelaDadosPessoais> createState() => _TelaDadosPessoaisState();
}

class _TelaDadosPessoaisState extends State<TelaDadosPessoais> {
  Autorizacao? _usuario;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _carregando = true;
    });

    Autorizacao? dados = await LocalStorageService.carregarAutorizacao();

    setState(() {
      _usuario = dados;
      _carregando = false;
    });
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
              Theme.of(context).highlightColor,
              Theme.of(context).highlightColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: <Widget>[
                // CABECALHO COM AVATAR
                Container(
                  width: ScreenUtil().setWidth(750),
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(255, 170, 0, 0)
                            .withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Color.fromARGB(255, 170, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Dados Pessoais',
                        style: EstilosTextosCustomizado.subTitle(context),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // CARREGANDO
                if (_carregando) ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ]
                // USUARIO CADASTRADO
                else if (_usuario != null) ...[
                  // CARD EMAIL
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(Icons.email,
                          color: Color.fromARGB(255, 170, 0, 0)),
                      title: const Text("E-mail",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      subtitle: Text(_usuario!.usuario,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  // CARD SENHA
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const ListTile(
                      leading: Icon(Icons.lock,
                          color: Color.fromARGB(255, 170, 0, 0)),
                      title: Text("Senha",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      subtitle: Text("********",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]
                // NENHUM USUARIO CADASTRADO
                else ...[
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: const ListTile(
                        leading: Icon(Icons.warning,
                            color: Colors.orange),
                        title: Text("Aviso",
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        subtitle: Text("Nenhum usuario cadastrado",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}