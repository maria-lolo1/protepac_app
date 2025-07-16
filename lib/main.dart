import 'package:flutter/material.dart';

import 'pages/esqueci_senha_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/minhas_manifestacoes_page.dart';
import 'pages/nova_manifestacao_page.dart';
import 'pages/perfil_page.dart';
import 'pages/primeiro_login_page.dart';

void main() => runApp(ProtepacApp());

class ProtepacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protepac',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        // Gerencia rotas com argumentos
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/primeiro_login':
            return MaterialPageRoute(builder: (_) => PrimeiroLoginPage());
          case '/esqueci_senha':
            return MaterialPageRoute(builder: (_) => EsqueciSenhaPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/nova_manifestacao':
            final tipo = settings.arguments as String? ?? '';
            return MaterialPageRoute(
              builder: (_) => NovaManifestacaoPage(tipo: tipo),
            );
          case '/minhas_manifestacoes':
            return MaterialPageRoute(builder: (_) => MinhasManifestacoesPage());
          case '/perfil':
            return MaterialPageRoute(builder: (_) => PerfilPage());
          default:
            return MaterialPageRoute(builder: (_) => LoginPage());
        }
      },
      // Apenas rotas "padrão" para evitar warnings do Flutter
      routes: {
        '/login': (_) => LoginPage(),
        '/primeiro_login': (_) => PrimeiroLoginPage(),
        '/esqueci_senha': (_) => EsqueciSenhaPage(),
        '/home': (_) => HomePage(),
        '/minhas_manifestacoes': (_) => MinhasManifestacoesPage(),
        '/perfil': (_) => PerfilPage(),
      },
    );
  }
}
