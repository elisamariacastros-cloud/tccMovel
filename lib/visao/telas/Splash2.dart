//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/estilos/EstilosTexto.dart';
import 'package:login/visao/telas/Principal.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/visao/util/CustomIcons.dart';

import 'package:login/visao/telas/Splash1.dart';
import 'package:login/visao/util/SocialIcons.dart';

//import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:login/main.dart';
import 'package:login/visao/util/WidgetsUteis.dart';

import 'Login.dart';

//classe inicial da tela
class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundo branco
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔥 LOGO
            Image.asset(
              'assets/logo.png',
              width: 200,
            ),

            const SizedBox(height: 40),

            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 200, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
