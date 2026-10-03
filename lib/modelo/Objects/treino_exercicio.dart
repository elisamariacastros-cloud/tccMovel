class TreinoExercicio {
  final int ordem;
  final int series;
  final String repeticoes;
  final String? carga;
  final String? descanso;
  final String? observacoes;
  final String nomeExercicio;

  TreinoExercicio({
    required this.ordem,
    required this.series,
    required this.repeticoes,
    this.carga,
    this.descanso,
    this.observacoes,
    required this.nomeExercicio,
  });

  factory TreinoExercicio.fromMap(Map<String, dynamic> map) {
    print(map);
    return TreinoExercicio(
      ordem: map['ordem'] ?? 0,
      series: map['series'] ?? 0,
      repeticoes: map['repeticoes']?.toString() ?? '',
      carga: map['carga']?.toString(),
      descanso: map['descanso']?.toString(),
      observacoes: map['observacoes'],
      nomeExercicio: map['exercicio']?['nome'] ?? '',
    );
  }
}