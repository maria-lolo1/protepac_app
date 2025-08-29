import 'package:flutter/material.dart';

class ElogiosAdmPage extends StatelessWidget {
  const ElogiosAdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    final List<Map<String, String>> elogios = [
      {
        "nome": "Carlos Alberto",
        "cpf": "023.754.753-40",
        "titulo": "Elogio",
        "data": "16/07/2025 18:33",
        "comentario": "Equipe atenciosa, resolveram tudo com rapidez!",
      },
      {
        "nome": "Fernanda Lima",
        "cpf": "321.654.987-00",
        "titulo": "Elogio",
        "data": "14/07/2025 09:15",
        "comentario": "Excelente atendimento, parabéns à equipe técnica.",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Elogios - ADM",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: azul),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: elogios.length,
        itemBuilder: (context, index) {
          final e = elogios[index];
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
                          e["nome"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: azul,
                          ),
                        ),
                      ],
                    ),
                    Text(e["cpf"]!, style: TextStyle(color: azul)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up, color: azul, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          e["titulo"]!,
                          style: TextStyle(
                            color: azul,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      e["data"]!,
                      style: TextStyle(color: laranja, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(e["comentario"]!, style: TextStyle(color: laranja)),
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
