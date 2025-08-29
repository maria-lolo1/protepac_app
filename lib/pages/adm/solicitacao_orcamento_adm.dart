import 'package:flutter/material.dart';

class SolicitacaoOrcamentoAdmPage extends StatelessWidget {
  const SolicitacaoOrcamentoAdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    final List<Map<String, String>> orcamentos = [
      {
        "nome": "Ricardo Mendes",
        "cpf": "123.987.456-00",
        "servico": "Instalação de Câmeras",
        "data": "25/08/2025 14:20",
        "comentario": "Gostaria de orçamento para instalar 4 câmeras externas.",
      },
      {
        "nome": "Juliana Ferreira",
        "cpf": "987.321.654-00",
        "servico": "Sistema de Alarme",
        "data": "24/08/2025 10:00",
        "comentario": "Preciso de orçamento para alarme em loja comercial.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Orçamentos - ADM",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: azul),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orcamentos.length,
        itemBuilder: (context, index) {
          final o = orcamentos[index];
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
                          o["nome"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: azul,
                          ),
                        ),
                      ],
                    ),
                    Text(o["cpf"]!, style: TextStyle(color: azul)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.request_page, color: azul, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          o["servico"]!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      o["data"]!,
                      style: TextStyle(color: laranja, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(o["comentario"]!, style: TextStyle(color: laranja)),
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
