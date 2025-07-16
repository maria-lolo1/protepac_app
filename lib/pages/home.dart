// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class HomePage extends StatelessWidget {
  // Nova lista de botões na ordem solicitada
  final List<_MenuButton> buttons = [
    _MenuButton(
      'Abertura de chamados técnicos',
      Icons.build_circle_rounded,
      '/novo_chamado_tecnico',
    ),
    _MenuButton(
      'Avisos de segurança',
      Icons.security_rounded,
      '/novo_aviso_seguranca',
    ),
    _MenuButton(
      'Indicação de novo cliente',
      Icons.person_add_alt_1,
      '/nova_indicacao_cliente',
    ),
    _MenuButton(
      'Solicitação orçamento',
      Icons.request_page_rounded,
      '/nova_solicitacao_orcamento',
    ),
    _MenuButton(
      'Elogio / Reclamação',
      Icons.thumbs_up_down_rounded,
      '/novo_elogio_reclamacao',
    ),
    _MenuButton('Sugestão', Icons.lightbulb_outline, '/nova_sugestao'),
  ];

  @override
  Widget build(BuildContext context) {
    // Pega largura da tela
    final screenWidth = MediaQuery.of(context).size.width;
    // Pega altura da tela
    final screenHeight = MediaQuery.of(context).size.height;
    // Ajusta tamanho do grid e fonte dependendo da largura da tela
    final crossAxisCount = 2;
    final isSmallDevice = screenWidth < 350;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset('assets/logo.png', height: 90),
            const SizedBox(height: 8),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Adapta aspect ratio para caber textos longos sem overflow
                  double aspectRatio = 1.35;
                  if (constraints.maxWidth < 350) {
                    aspectRatio = 1.1;
                  } else if (constraints.maxWidth < 410) {
                    aspectRatio = 1.2;
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 18, top: 8),
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: aspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final b = buttons[index];
                      return _MenuCard(
                        title: b.title,
                        icon: b.icon,
                        onTap: () {
                          Navigator.pushNamed(context, b.route);
                        },
                        isSmall: isSmallDevice,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0, // 0 = Home
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/minhas_manifestacoes');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}

class _MenuButton {
  final String title;
  final IconData icon;
  final String route;
  _MenuButton(this.title, this.icon, this.route);
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSmall;
  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    // Fontes responsivas
    double fontSize = isSmall ? 12 : 14;
    double iconSize = isSmall ? 30 : 35;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFFFD700), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Color(0xFF181883), size: iconSize),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF181883),
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
