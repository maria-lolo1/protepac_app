// lib/pages/chamado_adm.dart
import 'package:flutter/material.dart';

class ChamadoAdmPage extends StatelessWidget {
  ChamadoAdmPage({Key? key}) : super(key: key);

  final List<Map<String, String>> chamados = [
    {
      "nome": "João Silva",
      "cpf": "123.456.789-00",
      "titulo": "Chamado Técnico",
      "comentario": "Câmera da frente não está funcionando.",
      "data": "28/08/2025 10:45",
    },
    {
      "nome": "Maria Oliveira",
      "cpf": "987.654.321-00",
      "titulo": "Revisão de Alarme",
      "comentario": "O alarme disparou sem motivo aparente.",
      "data": "27/08/2025 15:12",
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
        iconTheme: IconThemeData(color: azul),
        title: Text(
          "Chamados - ADM",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chamados.length,
        itemBuilder: (context, index) {
          final chamado = chamados[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: laranja, width: 1.8),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (nome + cpf)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: azul, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          chamado["nome"]!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      chamado["cpf"]!,
                      style: TextStyle(color: azul, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Título + Data
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.build_circle, color: azul, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          chamado["titulo"]!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      chamado["data"]!,
                      style: TextStyle(
                        color: laranja,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Comentário
                Text(
                  chamado["comentario"]!,
                  style: TextStyle(color: Colors.orange[700], fontSize: 14),
                ),
                const SizedBox(height: 12),

                // Botões de ação (Responder e Status)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão Responder
                    InkWell(
                      onTap: () {
                        _abrirDialogResposta(context, chamado["nome"]!);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.reply, color: azul, size: 22),
                          const SizedBox(width: 6),
                          Text(
                            "Responder",
                            style: TextStyle(
                              color: azul,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botão Status (ampulheta/check)
                    IconButton(
                      icon: Icon(
                        Icons.hourglass_bottom,
                        color: laranja,
                        size: 26,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Status atualizado para Concluído"),
                            backgroundColor: Colors.green,
                          ),
                        );
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

  void _abrirDialogResposta(BuildContext context, String nome) {
    final TextEditingController respostaController = TextEditingController();
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Responder $nome",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: respostaController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Digite sua resposta...",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: laranja, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: laranja, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar", style: TextStyle(color: azul)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: laranja,
              foregroundColor: azul,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Resposta enviada com sucesso!"),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
