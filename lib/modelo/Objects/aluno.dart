import 'dart:convert';

class Aluno {
  final String nome;
  final String email;
  final String matricula;
  final String? telefone;
  final String? peso;
  final String? altura;
  final String? objetivo;

  Aluno({
    required this.nome,
    required this.email,
    required this.matricula,
    this.telefone,
    this.peso,
    this.altura,
    this.objetivo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'matricula': matricula,
      'telefone': telefone,
      'peso': peso,
      'altura': altura,
      'objetivo': objetivo,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      matricula: map['matricula'] ?? '',
      telefone: map['telefone'],
      peso: map['peso'],
      altura: map['altura'],
      objetivo: map['objetivo'],
    );
  }
}