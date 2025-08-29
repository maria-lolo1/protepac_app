import 'package:flutter/material.dart';

class AlertasProtepacAdmPage extends StatefulWidget {
  const AlertasProtepacAdmPage({Key? key}) : super(key: key);

  @override
  State<AlertasProtepacAdmPage> createState() => _AlertasProtepacAdmPageState();
}

class _AlertasProtepacAdmPageState extends State<AlertasProtepacAdmPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  void _publicarAlerta() {
    if (tituloController.text.trim().isEmpty ||
        descricaoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 🔔 Aqui você poderia integrar com Firebase ou outro sistema de push
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Alerta publicado e notificado aos clientes: ${tituloController.text}",
        ),
        backgroundColor: Colors.green,
      ),
    );

    // limpa os campos
    tituloController.clear();
    descricaoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Alertas - ADM",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: azul),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Center(
              child: Image.asset(
                "assets/logo.png",
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Campo Título
            Text(
              "Título do Alerta",
              style: TextStyle(
                fontSize: 16,
                color: laranja,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: tituloController,
              decoration: InputDecoration(
                hintText: "Digite o título do alerta",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Campo Descrição
            Text(
              "Descrição",
              style: TextStyle(
                fontSize: 16,
                color: laranja,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: descricaoController,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "Escreva os detalhes do alerta",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botão Publicar
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _publicarAlerta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: azul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                child: const Text("Publicar e Notificar Clientes"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
