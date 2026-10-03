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

  static const Color _vermelho = Color.fromARGB(255, 170, 0, 0);

  Widget _chip(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _vermelho.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          color: _vermelho,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void exibirAlerta(BuildContext context, Treino treino) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scroll) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: ListView(
                controller: scroll,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [

                  // Barrinha superior
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Título
                  Text(
                    "Treino ${treino.tipo}",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: _vermelho,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    treino.nome,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Lista de exercícios
                  ...treino.exercicios.asMap().entries.map((entry) {
                    final i = entry.key;
                    final e = entry.value;

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // Número
                          Container(
                            width: 28,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _vermelho,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${i + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Nome + informações
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  e.nomeExercicio,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                Wrap(
                                  spacing: 7,
                                  runSpacing: 7,
                                  children: [
                                    if (e.series > 0)
                                      _chip("${e.series} séries × ${e.repeticoes}"),

                                    if (e.carga != null)
                                      _chip("${e.carga} kg"),

                                    if (e.descanso != null)
                                      _chip("${e.descanso}s descanso"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _cardTreino(Treino treino) {
    final qtd = treino.exercicios.length;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => exibirAlerta(context, treino),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _vermelho,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    treino.tipo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        treino.nome,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$qtd ${qtd == 1 ? 'exercício' : 'exercícios'}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: _vermelho),
              ],
            ),
          ),
        ),
      ),
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

  static String subtitulo = "TREINOS DISPONÍVEIS";
  static String titulo = "Meus treinos";
}