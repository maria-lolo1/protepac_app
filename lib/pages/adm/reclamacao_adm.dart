import 'package:flutter/material.dart';

class ReclamacaoAdmPage extends StatelessWidget {
  const ReclamacaoAdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    final List<Map<String, String>> reclamacoes = [
      {
        "nome": "Paulo Souza",
        "cpf": "123.456.789-00",
        "titulo": "Reclamação",
        "data": "20/07/2025 15:30",
        "comentario": "Demora no atendimento do chamado técnico.",
      },
      {
        "nome": "Ana Costa",
        "cpf": "456.789.123-00",
        "titulo": "Reclamação",
        "data": "19/07/2025 11:20",
        "comentario": "Sistema de alarme disparou sem motivo várias vezes.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Reclamações - ADM",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: azul),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reclamacoes.length,
        itemBuilder: (context, index) {
          final r = reclamacoes[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: laranja, width: 1.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: azul, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          r["nome"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: azul,
                          ),
                        ),
                      ],
                    ),
                    Text(r["cpf"]!, style: TextStyle(color: azul)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_down, color: azul, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          r["titulo"]!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      r["data"]!,
                      style: TextStyle(color: laranja, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(r["comentario"]!, style: TextStyle(color: laranja)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.reply, color: azul),
                      label: Text("Responder", style: TextStyle(color: azul)),
                    ),
                    IconButton(
                      icon: Icon(Icons.hourglass_empty, color: laranja),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
