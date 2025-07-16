import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 32),

              // CPF label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CPF',
                  style: TextStyle(
                    color: Color(0xFFFF9900), // dark orange
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // CPF field
              TextField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color(0xFF111132)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Senha label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Senha',
                  style: TextStyle(
                    color: Color(0xFFFF9900), // dark orange
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Senha field
              TextField(
                controller: senhaController,
                obscureText: true,
                style: TextStyle(color: Color(0xFF111132)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Botão Logar
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Exemplo de login teste
                    if (cpfController.text == '12345678900' && senhaController.text == '1234') {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // Mostra alerta de erro (opcional)
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Erro'),
                          content: Text('CPF ou senha inválidos!'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD700),
                    foregroundColor: Color(0xFF181883),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.2,
                    ),
                  ),
                  child: Text('LOGAR'),
                ),
              ),
              const SizedBox(height: 20),

              // Links
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/primeiro_login'),
                child: Text(
                  'Primeiro login no app? Clique aqui',
                  style: TextStyle(
                    color: Color(0xFF181883),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/esqueci_senha'),
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    color: Color(0xFF181883),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
