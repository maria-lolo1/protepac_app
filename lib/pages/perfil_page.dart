import 'package:flutter/material.dart';
import 'package:protepac/widgets/custom_bottom_nav_bar.dart';

class PerfilPage extends StatelessWidget {
  final String cpf = '12345678901'; // Troque pelo CPF real
  final String senha = '123456'; // Troque pela senha real

  // Mascara CPF: ***.***.789-01
  String _maskCpf(String cpf) {
    if (cpf.length != 11) return cpf;
    return '***.***.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(child: Image.asset('assets/logo.png', height: 100)),
              const SizedBox(height: 40),
              Text(
                'Meu Perfil',
                style: TextStyle(
                  color: Color(0xFFFF9900),
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 25),
              // CPF Box
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CPF',
                  style: TextStyle(
                    color: Color(0xFFFF9900),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFFD700), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _maskCpf(cpf),
                  style: TextStyle(
                    color: Color(0xFF181883),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              // Senha Box
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Senha',
                  style: TextStyle(
                    color: Color(0xFFFF9900),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: EdgeInsets.only(bottom: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFFD700), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '*' * senha.length,
                  style: TextStyle(
                    color: Color(0xFF181883),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              // Botão sair
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD700),
                    foregroundColor: Color(0xFF181883),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  child: Text('Sair do Aplicativo'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/minhas_manifestacoes');
          }
        },
      ),
    );
  }
}
