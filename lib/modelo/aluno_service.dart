import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/modelo/Objects/aluno.dart';
import 'package:login/config/api_config.dart';

class AlunoService {
  Future<Aluno?> buscarMeusDados(String token) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/me');

    final resp = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final dados = jsonDecode(resp.body);
      return Aluno.fromMap(dados);
    } else {
      return null;
    }
  }
}