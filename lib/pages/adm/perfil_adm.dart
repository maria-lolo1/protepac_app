// lib/pages/adm/perfil_adm.dart

import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_geral.dart';

class PerfilAdmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: azul),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Perfil - Administrador",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: laranja,
                child: Icon(Icons.person, size: 60, color: azul),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Nome do Administrador",
              style: TextStyle(
                color: azul,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "adm@protepac.com.br",
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.settings, color: azul),
              title: Text("Configurações", style: TextStyle(color: azul)),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock, color: azul),
              title: Text("Alterar Senha", style: TextStyle(color: azul)),
              onTap: () {
                Navigator.pushNamed(context, "/esqueci_senha");
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Sair", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarGeral(
        selectedIndex: 2, // ✅ agora Perfil ADM fica selecionado
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
