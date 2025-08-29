import 'package:flutter/material.dart';

class IndicacaoClienteAdmPage extends StatelessWidget {
  const IndicacaoClienteAdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    final List<Map<String, String>> indicacoes = [
      {
        "nome": "Marcos Paulo",
        "cpf": "123.654.789-00",
        "telefone": "(51) 99999-1111",
        "email": "marcos@email.com",
        "servico": "Câmeras de Segurança",
        "comentario": "Indico para orçamento de instalação em residência.",
        "data": "22/08/2025 16:45",
      },
      {
        "nome": "Luciana Prado",
        "cpf": "321.987.654-00",
        "telefone": "(51) 98888-2222",
        "email": "luciana@email.com",
        "servico": "Alarme",
        "comentario": "Indicada para orçamento em loja de roupas.",
        "data": "21/08/2025 09:30",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Indicações - ADM",
          style: TextStyle(color: azul, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: azul),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: indicacoes.length,
        itemBuilder: (context, index) {
          final i = indicacoes[index];
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
                // Nome + CPF
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: azul, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          i["nome"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: azul,
                          ),
                        ),
                      ],
                    ),
                    Text(i["cpf"]!, style: TextStyle(color: azul)),
                  ],
                ),
                const SizedBox(height: 6),
                // Telefone + Email
                Row(
                  children: [
                    Icon(Icons.phone, color: azul, size: 18),
                    const SizedBox(width: 4),
                    Text(i["telefone"]!, style: TextStyle(color: azul)),
                    const SizedBox(width: 12),
                    Icon(Icons.email, color: azul, size: 18),
                    const SizedBox(width: 4),
                    Text(i["email"]!, style: TextStyle(color: azul)),
                  ],
                ),
                const SizedBox(height: 6),
                // Serviço
                Row(
                  children: [
                    Icon(Icons.business, color: azul, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      i["servico"]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: azul,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Comentário
                Text(i["comentario"]!, style: TextStyle(color: laranja)),
                const SizedBox(height: 6),
                // Data
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    i["data"]!,
                    style: TextStyle(color: laranja, fontSize: 13),
                  ),
                ),
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
