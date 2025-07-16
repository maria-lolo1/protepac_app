import 'package:flutter/material.dart';

import '../widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  final List<_MenuButton> buttons = [
    _MenuButton('Elogio', Icons.thumb_up_alt_rounded, 'elogio'),
    _MenuButton('Reclamação', Icons.thumb_down_alt_rounded, 'reclamacao'),
    _MenuButton(
      'Abertura de chamado técnico',
      Icons.build_circle_rounded,
      'chamado',
    ),
    _MenuButton('Avisos de segurança', Icons.security_rounded, 'avisos'),
    _MenuButton('Ouvidoria', Icons.record_voice_over, 'ouvidoria'),
    _MenuButton(
      'Indicação de novo cliente',
      Icons.person_add_alt_1,
      'indicacao',
    ),
    _MenuButton('Sugestão', Icons.lightbulb_outline, 'sugestao'),
    _MenuButton('Sair', Icons.logout, 'logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              SizedBox(height: 8),
              Image.asset('assets/logo.png', height: 90),
              const SizedBox(height: 35),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    childAspectRatio: 1.35,
                  ),
                  itemBuilder: (context, index) {
                    final b = buttons[index];
                    return _MenuCard(
                      title: b.title,
                      icon: b.icon,
                      onTap: () {
                        if (b.tipo == 'logout') {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            '/nova_manifestacao',
                            arguments: b.tipo,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0, // Aqui 0 = Home
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
  final String tipo; // muda de 'route' para 'tipo'
  _MenuButton(this.title, this.icon, this.tipo);
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Color(0xFF181883), size: 36),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF181883),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
