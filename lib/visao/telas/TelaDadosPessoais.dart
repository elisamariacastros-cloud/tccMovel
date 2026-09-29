import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/modelo/local_storage_service.dart';
import 'package:login/modelo/Objects/aluno.dart';

class TelaDadosPessoais extends StatefulWidget {
  const TelaDadosPessoais({super.key, required this.title});

  final String title;

  @protected
  @override
  State<TelaDadosPessoais> createState() => _TelaDadosPessoaisState();
}

class _TelaDadosPessoaisState extends State<TelaDadosPessoais> {
  Aluno? _aluno;
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

    Aluno? dados = await LocalStorageService.carregarAluno();

    setState(() {
      _aluno = dados;
      _carregando = false;
    });
  }

  Widget _cardDado(IconData icone, String titulo, String? valor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icone, color: const Color.fromARGB(255, 170, 0, 0)),
        title: Text(titulo,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(
          (valor == null || valor.isEmpty) ? "Não informado" : valor,
          style:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
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
                // ALUNO CARREGADO
                else if (_aluno != null) ...[
                  _cardDado(Icons.person, "Nome", _aluno!.nome),
                  _cardDado(Icons.email, "E-mail", _aluno!.email),
                  _cardDado(Icons.badge, "Matrícula", _aluno!.matricula),
                  _cardDado(Icons.phone, "Telefone", _aluno!.telefone),
                  _cardDado(Icons.monitor_weight, "Peso (kg)", _aluno!.peso),
                  _cardDado(Icons.height, "Altura (m)", _aluno!.altura),
                  _cardDado(Icons.flag, "Objetivo", _aluno!.objetivo),
                ]
                // NENHUM ALUNO CADASTRADO
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
                        subtitle: Text("Nenhum aluno cadastrado",
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