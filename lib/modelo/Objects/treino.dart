import 'package:login/modelo/Objects/treino_exercicio.dart';

class Treino {
  final int id;
  final String tipo;
  final String nome;
  final String? descricao;
  final List<TreinoExercicio> exercicios;

  Treino({
    required this.id,
    required this.tipo,
    required this.nome,
    this.descricao,
    required this.exercicios,
  });

  factory Treino.fromMap(Map<String, dynamic> map) {
    return Treino(
      id: map['id'],
      tipo: map['tipo'] ?? '',
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      exercicios: (map['treino_exercicios'] as List<dynamic>? ?? [])
          .map((e) => TreinoExercicio.fromMap(e))
          .toList(),
    );
  }
}