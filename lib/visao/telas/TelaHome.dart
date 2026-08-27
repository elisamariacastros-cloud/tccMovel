import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/modelo/ItemListView.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/util/WidgetsUteis.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key, required this.title});

  final String title;

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  void exibirAlerta(BuildContext context, List<String> exercicios) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 350, // diminui a largura
            vertical: 24,
          ),
          title: const Text("Exercícios"),
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
                  Column(
                    children: linhaTempo.map((item) {
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            "Treino ${item.treino}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item.descricao),
                          onTap: () {
                            List<String> exercicios = [];

                            if (item.treino == 'A') {
                              exercicios = [
                                "Supino",
                                "Crucifixo",
                                "Flexão",
                                "Cardio"
                              ];
                            } else if (item.treino == 'B') {
                              exercicios = [
                                "Agachamento",
                                "Leg press",
                                "Extensora",
                                "Cardio"
                              ];
                            } else if (item.treino == 'C') {
                              exercicios = [
                                "Puxada",
                                "Remada",
                                "Barra fixa",
                                "Cardio"
                              ];
                            } else if (item.treino == 'D') {
                              exercicios = [
                                "Hip thrust",
                                "Afundo",
                                "Glúteo máquina",
                                "Cardio"
                              ];
                            }

                            exibirAlerta(context, exercicios);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<ItemListView> linhaTempo = [
  ItemListView(treino: 'A', descricao: 'PEITORAL'),
  ItemListView(treino: 'B', descricao: 'QUADRICEPS'),
  ItemListView(treino: 'C', descricao: 'COSTA'),
  ItemListView(treino: 'D', descricao: 'GLUTEO'),
];

class Internacionalizacao {
  static String valorDisponivel = "valor total ainda disponível";
  static String subtitulo = "Treinos disponiveis";
  static String titulo = "Meus treinos";
}
