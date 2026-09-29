import 'package:login/modelo/Objects/treino.dart';

class Ficha {
  final int id;
  final String nome;
  final DateTime? dataInicio;
  final DateTime? dataFim;
  final String? observacoes;
  final List<Treino> treinos;

  Ficha({
    required this.id,
    required this.nome,
    this.dataInicio,
    this.dataFim,
    this.observacoes,
    required this.treinos,
  });

  factory Ficha.fromMap(Map<String, dynamic> map) {
    return Ficha(
      id: map['id'],
      nome: map['nome'] ?? '',
      dataInicio: map['data_inicio'] != null
          ? DateTime.tryParse(map['data_inicio'])
          : null,
      dataFim:
      map['data_fim'] != null ? DateTime.tryParse(map['data_fim']) : null,
      observacoes: map['observacoes'],
      treinos: (map['treinos'] as List<dynamic>? ?? [])
          .map((t) => Treino.fromMap(t))
          .toList(),
    );
  }
}