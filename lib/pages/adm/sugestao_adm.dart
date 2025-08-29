import 'package:flutter/material.dart';

class SugestaoAdmPage extends StatelessWidget {
  final List<Map<String, String>> sugestoes = [
    {
      'nome': 'Pedro Santos',
      'cpf': '321.654.987-00',
      'titulo': 'Melhoria no App',
      'data': '28/08/2025 14:20',
      'mensagem': 'Seria ótimo poder acompanhar o status em tempo real.',
    },
    {
      'nome': 'Ana Souza',
      'cpf': '789.123.456-00',
      'titulo': 'Atendimento',
      'data': '27/08/2025 16:45',
      'mensagem': 'Sugiro ampliar o horário de atendimento.',
    },
  ];

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
          "Sugestões - ADM",
          style: TextStyle(
            color: azul,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sugestoes.length,
        itemBuilder: (context, index) {
          final s = sugestoes[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: laranja, width: 1.5),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome e CPF
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: azul, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          s['nome']!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      s['cpf']!,
                      style: TextStyle(color: azul, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Título e Data
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: azul, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          s['titulo']!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      s['data']!,
                      style: TextStyle(color: laranja, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Mensagem
                Text(
                  s['mensagem']!,
                  style: TextStyle(color: laranja, fontSize: 14),
                ),
                const SizedBox(height: 8),
                // Rodapé - Responder e Ampulheta
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // Aqui pode abrir um modal de resposta
                      },
                      icon: Icon(Icons.reply, color: azul, size: 18),
                      label: Text("Responder", style: TextStyle(color: azul)),
                    ),
                    IconButton(
                      icon: Icon(Icons.hourglass_bottom, color: laranja),
                      onPressed: () {
                        // Lógica de alterar status
                      },
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
