import 'package:flutter/material.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/telas/Login.dart';
import 'package:login/visao/util/WidgetsUteis.dart';

class TelaRecuperacaoSenha extends StatefulWidget {
  @override
  _TelaRecuperacaoSenhaState createState() => _TelaRecuperacaoSenhaState();
}

class _TelaRecuperacaoSenhaState extends State<TelaRecuperacaoSenha> {
  telaLogin(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login(title: 'Login')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //ao clicar na seta ela volta pra tela login
            telaLogin(context);
          },
        ),
        title: Text('Recuperação de Senha'),
      ),
      backgroundColor: Colors.grey[100], // fundo mais bonito
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 450,
            height: 380, // 👈controla a largura do card
            child: Card(
              color: Colors.grey[200],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 👈 evita card gigante
                  children: [
                    Text(
                      'E-mail',
                      style: EstilosTextosCustomizado.formField(context),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Insira seu e-mail',
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enviaremos um link de recuperação para este e-mail',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    WidgetsUteis().botaoSemBorda(
                      context: context,
                      texto: 'ENVIAR',
                      executa: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
