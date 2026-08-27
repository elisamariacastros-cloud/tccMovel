import 'package:flutter/material.dart';
import 'package:login/visao/telas/TelaDadosPessoais.dart';
import 'package:login/visao/telas/TelaHome.dart';
import 'package:login/visao/util/WidgetsUteis.dart';
import 'package:login/modelo/local_storage_service.dart';
import 'package:login/visao/telas/Login.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  //variáveis
  int _currentIndex = 0;

  List<Widget> _screens = [
    TelaHome(title: 'Primeira tela'),
    TelaDadosPessoais(title: 'Segunda tela'),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  //barra de títulos
  AppBar _appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, color: const Color.fromARGB(255, 170, 0, 0)),
          WidgetsUteis().espacoHorizontal5,
          WidgetsUteis().espacoHorizontal5,
          Text(
            Internacionalizacao.titulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await LocalStorageService.desgravarAutorizacao();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login(title: 'Login')),
            );
          },
        ),
      ],
    );
  }

  //barra de menu
  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: Internacionalizacao.opt1,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: Internacionalizacao.opt2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}

class Internacionalizacao {
  static String opt1 = "FICHA TREINO";
  static String opt2 = "DADOS PESSOAIS";
  static String titulo = "MENU";
}