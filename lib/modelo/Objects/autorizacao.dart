import 'dart:convert';

class Autorizacao {

  final String usuario;
  final String senha;
  final String token_autorizacao;


  //construtor da classe que recer cada um de seus atributos
  Autorizacao({required this.usuario,required this.senha, required this.token_autorizacao});

  // Converte o objeto para um Map
  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'senha': senha,
      'token_autorizacao': token_autorizacao,
    };
  }

  // Cria um objeto a partir de un Map
  factory Autorizacao.fromMap(Map<String, dynamic> map) {
    return Autorizacao(
      usuario: map['usuario'] ?? '',
      senha: map['senha'] ?? '',
      token_autorizacao: map['token_autorizacao'] ?? '',
    );
  }

  // Facilita a conversão de uma lista de objetos para uma String JSON
  static String encode(List<Autorizacao> Autorizacaos) => json.encode(
    Autorizacaos.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  // Facilita a conversão de uma String JSON para uma lista de objetos
  static List<Autorizacao> decode(String AutorizacaosJson) =>
      (json.decode(AutorizacaosJson) as List<dynamic>)
          .map<Autorizacao>((item) => Autorizacao.fromMap(item))
          .toList();
}
