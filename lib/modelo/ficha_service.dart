import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/modelo/Objects/ficha.dart';
import 'package:login/config/api_config.dart';

class FichaService {
  Future<Ficha?> buscarFichaMaisRecente(String token) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/minha-ficha');

    final resp = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode != 200) {
      return null;
    }

    final List<dynamic> lista = jsonDecode(resp.body);

    if (lista.isEmpty) {
      return null;
    }

    final fichas = lista.map((f) => Ficha.fromMap(f)).toList();

    // ordena pela data de início, mais recente primeiro
    fichas.sort((a, b) {
      if (a.dataInicio == null) return 1;
      if (b.dataInicio == null) return -1;
      return b.dataInicio!.compareTo(a.dataInicio!);
    });

    return fichas.first;
  }
}