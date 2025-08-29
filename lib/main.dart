import 'package:flutter/material.dart';

import 'pages/login/esqueci_senha.dart';
import 'pages/clientes/home.dart';
import 'pages/login/login.dart';
import 'pages/clientes/minhas_manifestacoes.dart';
import 'pages/clientes/nova_indicacao_cliente.dart';
import 'pages/clientes/nova_solicitacao_orcamento.dart';
import 'pages/clientes/nova_sugestao.dart';
import 'pages/clientes/novo_aviso_seguranca.dart';
import 'pages/clientes/novo_chamado_tecnico.dart';
import 'pages/clientes/novo_elogio.dart'; // 👈 NOVO import
import 'pages/clientes/nova_reclamacao.dart'; // 👈 NOVO import
import 'pages/perfil.dart';
import 'pages/perfil_geral.dart';
import 'pages/login/primeiro_login.dart';
import 'pages/adm/manifestacoes_geral.dart';

void main() => runApp(ProtepacApp());

class ProtepacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protepac',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Usa o tema do sistema (claro/escuro)
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF181883), // azul
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF181883), // azul
          secondary: const Color(0xFFFF9900), // laranja
          surface: Colors.white,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // fundo preto
        primaryColor: const Color(0xFFFF9900), // laranja no lugar do azul
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFF9900), // laranja
          secondary: const Color(0xFFFFD700), // amarelo mantido
          surface: Colors.black,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginPage());
          case '/primeiro_login':
            return MaterialPageRoute(builder: (_) => PrimeiroLoginPage());
          case '/esqueci_senha':
            return MaterialPageRoute(builder: (_) => EsqueciSenhaPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/minhas_manifestacoes':
            return MaterialPageRoute(builder: (_) => MinhasManifestacoesPage());
          case '/perfil':
            return MaterialPageRoute(builder: (_) => PerfilPage());
          case '/perfil_geral':
            return MaterialPageRoute(builder: (_) => PerfilGeralPage());
          case '/nova_indicacao_cliente':
            return MaterialPageRoute(
              builder: (_) => NovaIndicacaoClientePage(),
            );
          case '/nova_solicitacao_orcamento':
            return MaterialPageRoute(
              builder: (_) => NovaSolicitacaoOrcamentoPage(),
            );
          case '/nova_sugestao':
            return MaterialPageRoute(builder: (_) => NovaSugestaoPage());
          case '/novo_aviso_seguranca':
            return MaterialPageRoute(builder: (_) => NovoAvisoSegurancaPage());
          case '/novo_chamado_tecnico':
            return MaterialPageRoute(builder: (_) => NovoChamadoTecnicoPage());
          case '/novo_elogio': // 👈 agora separado
            return MaterialPageRoute(builder: (_) => NovoElogioPage());
          case '/nova_reclamacao': // 👈 agora separado
            return MaterialPageRoute(builder: (_) => NovaReclamacaoPage());
          case '/manifestacoes_geral':
            return MaterialPageRoute(builder: (_) => ManifestacoesGeralPage());
          default:
            return MaterialPageRoute(builder: (_) => LoginPage());
        }
      },
      routes: {
        '/login': (_) => LoginPage(),
        '/primeiro_login': (_) => PrimeiroLoginPage(),
        '/esqueci_senha': (_) => EsqueciSenhaPage(),
        '/home': (_) => HomePage(),
        '/minhas_manifestacoes': (_) => MinhasManifestacoesPage(),
        '/perfil': (_) => PerfilPage(),
        '/perfil_geral': (_) => PerfilGeralPage(),
        '/nova_indicacao_cliente': (_) => NovaIndicacaoClientePage(),
        '/nova_solicitacao_orcamento': (_) => NovaSolicitacaoOrcamentoPage(),
        '/nova_sugestao': (_) => NovaSugestaoPage(),
        '/novo_aviso_seguranca': (_) => NovoAvisoSegurancaPage(),
        '/novo_chamado_tecnico': (_) => NovoChamadoTecnicoPage(),
        '/novo_elogio': (_) => NovoElogioPage(), // 👈 novo
        '/nova_reclamacao': (_) => NovaReclamacaoPage(), // 👈 novo
        '/manifestacoes_geral': (_) => ManifestacoesGeralPage(),
      },
    );
  }
}
