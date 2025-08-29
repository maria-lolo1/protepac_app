// lib/pages/adm/home_adm.dart

import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_geral.dart';

class HomeAdmPage extends StatelessWidget {
  final List<_MenuButton> buttons = [
    _MenuButton(
      'Chamados Técnicos,\nManutenções e Revisões',
      Icons.build_circle_rounded,
      '/chamado_adm',
    ),
    _MenuButton('Alertas Protepac', Icons.warning, '/alertas_protepac_adm'),
    _MenuButton(
      'Indicações de Clientes',
      Icons.person_add_alt_1,
      '/indicacao_cliente_adm',
    ),
    _MenuButton(
      'Orçamentos',
      Icons.request_page_rounded,
      '/solicitacao_orcamento_adm',
    ),
    _MenuButton('Elogios', Icons.thumb_up, '/elogios_adm'), // ✅ corrigido
    _MenuButton('Reclamações', Icons.thumb_down, '/reclamacao_adm'),
    _MenuButton('Sugestões', Icons.lightbulb_outline, '/sugestao_adm'),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = 2;
    final isSmallDevice = screenWidth < 350;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final b = buttons[index];
                return _MenuCard(
                  title: b.title,
                  icon: b.icon,
                  onTap: () {
                    Navigator.pushNamed(context, b.route);
                  },
                  isSmall: isSmallDevice,
                );
              }, childCount: buttons.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: screenWidth < 350
                    ? 1.1
                    : screenWidth < 410
                    ? 1.2
                    : 1.35,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBarGeral(
        selectedIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home_adm');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/adicionar_adm');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/perfil_adm');
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
    double fontSize = isSmall ? 12 : (title.length > 30 ? 11 : 14);
    double iconSize = isSmall ? 35 : 40;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFFD700), width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF181883), size: iconSize),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF181883),
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
