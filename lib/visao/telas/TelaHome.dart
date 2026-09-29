import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/WidgetsUteis.dart';
import 'package:login/modelo/local_storage_service.dart';
import 'package:login/modelo/ficha_service.dart';
import 'package:login/modelo/Objects/ficha.dart';
import 'package:login/modelo/Objects/treino.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key, required this.title});

  final String title;

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  Ficha? _ficha;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarFicha();
  }

  Future<void> _carregarFicha() async {
    setState(() {
      _carregando = true;
    });

    final autorizacao = await LocalStorageService.carregarAutorizacao();

    if (autorizacao != null) {
      final ficha = await FichaService()
          .buscarFichaMaisRecente(autorizacao.token_autorizacao);

      setState(() {
        _ficha = ficha;
        _carregando = false;
      });
    } else {
      setState(() {
        _carregando = false;
      });
    }
  }

  void exibirAlerta(BuildContext context, Treino treino) {
    List<String> exercicios = treino.exercicios.map((e) {
      final detalhes = [
        e.series > 0 ? "${e.series}x${e.repeticoes}" : null,
        e.carga != null ? "carga ${e.carga}" : null,
      ].whereType<String>().join(" - ");

      return detalhes.isEmpty
          ? e.nomeExercicio
          : "${e.nomeExercicio} ($detalhes)";
    }).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 350,
            vertical: 24,
          ),
          title: Text("Treino ${treino.tipo} - ${treino.nome}"),
          content: WidgetsUteis.listaExercicios(exercicios),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(750, 1304));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Internacionalizacao.titulo,
          style: TextStyle(
            color: const Color.fromARGB(255, 170, 0, 0),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                blurRadius: 4,
                offset: Offset(2, 2),
                color: const Color.fromARGB(66, 245, 102, 102),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('TREINE.',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('SUPERE.',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('EVOLUA.',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 170, 0, 0),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'MEUS TREINOS',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 170, 0, 0),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    Internacionalizacao.subtitulo,
                    style: EstilosTextosCustomizado.subTitle(context),
                  ),
                  SizedBox(height: 16),

                  if (_carregando) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (_ficha == null) ...[
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.warning, color: Colors.orange),
                        title: Text("Nenhuma ficha encontrada"),
                        subtitle:
                        Text("Fale com seu personal para criar uma ficha."),
                      ),
                    ),
                  ] else ...[
                    Column(
                      children: _ficha!.treinos.map((treino) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor:
                              const Color.fromARGB(255, 170, 0, 0)
                                  .withOpacity(0.1),
                              child: const Icon(
                                Icons.fitness_center,
                                color: Color.fromARGB(255, 170, 0, 0),
                              ),
                            ),
                            title: Text(
                              "Treino ${treino.tipo}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(treino.nome),
                            onTap: () => exibirAlerta(context, treino),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Internacionalizacao {
  static String valorDisponivel = "valor total ainda disponível";
  static String subtitulo = "Treinos disponiveis";
  static String titulo = "Meus treinos";
}