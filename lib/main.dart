import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/primeiro_login_page.dart';
import 'pages/home_page.dart';
import 'pages/nova_manifestacao_page.dart';
import 'pages/minhas_manifestacoes_page.dart';
import 'pages/perfil_page.dart';
import 'pages/esqueci_senha_page.dart';

void main() => runApp(ProtepacApp());

class ProtepacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protopac',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginPage(),
        '/primeiro_login': (_) => PrimeiroLoginPage(),  // <- CORRETO
        '/esqueci_senha': (_) => EsqueciSenhaPage(),    // <- CORRETO
        // outras rotas...
      },
    );
  }
}
