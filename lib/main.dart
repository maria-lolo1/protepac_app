import 'package:flutter/material.dart';

import 'pages/esqueci_senha.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/minhas_manifestacoes.dart';
import 'pages/nova_indicacao_cliente.dart';
import 'pages/nova_solicitacao_orcamento.dart';
import 'pages/nova_sugestao.dart';
import 'pages/novo_aviso_seguranca.dart';
import 'pages/novo_chamado_tecnico.dart';
import 'pages/novo_elogio_reclamacao.dart';
import 'pages/perfil.dart';
import 'pages/primeiro_login.dart';

void main() => runApp(ProtepacApp());

class ProtepacApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protepac',
      debugShowCheckedModeBanner: false,
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
          case '/novo_elogio_reclamacao':
            return MaterialPageRoute(
              builder: (_) => NovoElogioReclamacaoPage(),
            );
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
        '/nova_indicacao_cliente': (_) => NovaIndicacaoClientePage(),
        '/nova_solicitacao_orcamento': (_) => NovaSolicitacaoOrcamentoPage(),
        '/nova_sugestao': (_) => NovaSugestaoPage(),
        '/novo_aviso_seguranca': (_) => NovoAvisoSegurancaPage(),
        '/novo_chamado_tecnico': (_) => NovoChamadoTecnicoPage(),
        '/novo_elogio_reclamacao': (_) => NovoElogioReclamacaoPage(),
      },
    );
  }
}
