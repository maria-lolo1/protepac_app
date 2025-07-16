import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  final List<_MenuButton> buttons = [
    _MenuButton('Reclamação', Icons.thumb_down_alt_rounded, '/nova_manifestacao'),
    _MenuButton('Ouvidoria', Icons.record_voice_over, '/nova_manifestacao'),
    _MenuButton('Indicação de novo cliente', Icons.person_add_alt_1, '/nova_manifestacao'),
    _MenuButton('Abertura de chamado técnico', Icons.build_circle_rounded, '/nova_manifestacao'),
    _MenuButton('Sugestão', Icons.lightbulb_outline, '/nova_manifestacao'),
    _MenuButton('Elogio', Icons.thumb_up_alt_rounded, '/nova_manifestacao'),
    _MenuButton('Avisos de segurança', Icons.security_rounded, '/nova_manifestacao'),
    _MenuButton('Sair', Icons.logout, '/login'),
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
              SizedBox(height: 12),
              Image.asset('assets/logo.png', height: 90),
              const SizedBox(height: 18),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: buttons
                      .map((b) => _MenuCard(
                    title: b.title,
                    icon: b.icon,
                    onTap: () {
                      if (b.title == 'Sair') {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      } else {
                        Navigator.pushNamed(context, b.route);
                      }
                    },
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0, // Home é 0
        onTap: (index) {
          if (index == 0) {
            // Já está na Home, não faz nada
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
  const _MenuCard({required this.title, required this.icon, required this.onTap});

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
              Icon(
                icon,
                color: Color(0xFF181883),
                size: 36,
              ),
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
