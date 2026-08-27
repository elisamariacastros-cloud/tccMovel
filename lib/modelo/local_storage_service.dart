import 'package:login/modelo/Objects/autorizacao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String AUTORIZACAO = 'autorizacao';

  // Salvar a autorizacao
  static Future<void> salvarAutorizacao(Autorizacao auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(auth.toMap());
    await prefs.setString(AUTORIZACAO, encodedData);
  }

  // Remover a autorizacao
  static Future<void> desgravarAutorizacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AUTORIZACAO);
  }

  // Carregar a autorizacao
  static Future<Autorizacao?> carregarAutorizacao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? authJson = prefs.getString(AUTORIZACAO);

    if (authJson == null) {
      return null;
    }

    final Map<String, dynamic> map = json.decode(authJson);
    return Autorizacao.fromMap(map);
  }
}