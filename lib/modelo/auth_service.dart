import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/modelo/Objects/autorizacao.dart';
import 'package:login/config/api_config.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String senha) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/login');

    final resp = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': senha}),
    );

    final dados = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      final autorizacao = Autorizacao(
        usuario: email,
        senha: senha,
        token_autorizacao: dados['token'],
      );
      return {'sucesso': true, 'autorizacao': autorizacao};
    } else {
      return {'sucesso': false, 'mensagem': dados['message'] ?? 'Credenciais inválidas'};
    }
  }
}