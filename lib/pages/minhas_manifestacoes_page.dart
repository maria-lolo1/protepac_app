import 'package:flutter/material.dart';
import 'package:protepac/widgets/custom_bottom_nav_bar.dart';

class MinhasManifestacoesPage extends StatefulWidget {
  @override
  State<MinhasManifestacoesPage> createState() =>
      _MinhasManifestacoesPageState();
}

class _MinhasManifestacoesPageState extends State<MinhasManifestacoesPage> {
  List<Manifestacao> manifestacoes = [
    Manifestacao(
      tipo: 'Elogio',
      icon: Icons.thumb_up_alt_rounded,
      texto: 'Atendimento excelente e rápido!',
      dataHora: DateTime(2025, 7, 16, 18, 33),
    ),
    Manifestacao(
      tipo: 'Reclamação',
      icon: Icons.thumb_down_alt_rounded,
      texto: 'Demorou muito para resolver meu problema.',
      dataHora: DateTime(2025, 7, 15, 9, 15),
    ),
    Manifestacao(
      tipo: 'Chamado técnico',
      icon: Icons.build_circle_rounded,
      texto: 'Preciso de suporte para o alarme do escritório.',
      dataHora: DateTime(2025, 7, 14, 14, 55),
    ),
    Manifestacao(
      tipo: 'Avisos de segurança',
      icon: Icons.security_rounded,
      texto: 'Parabéns pelas dicas de segurança enviadas!',
      dataHora: DateTime(2025, 7, 13, 11, 25),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Minhas Manifestações',
          style: TextStyle(
            color: Color(0xFF181883),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF181883)),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ), // Adiciona espaço extra no final!
        itemCount: manifestacoes.length,
        separatorBuilder: (_, __) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final m = manifestacoes[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFFFD700), width: 2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icone + Titulo + Data
                Row(
                  children: [
                    Icon(m.icon, color: Color(0xFF181883)),
                    SizedBox(width: 7),
                    Text(
                      m.tipo,
                      style: TextStyle(
                        color: Color(0xFF181883),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${_formatDataHora(m.dataHora)}',
                      style: TextStyle(
                        color: Color(0xFFFF9900),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Text(
                  m.texto,
                  style: TextStyle(color: Color(0xFFFF9900), fontSize: 15),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    // Editar
                    OutlinedButton.icon(
                      onPressed: () {
                        _editarManifestacao(context, index, m);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[800],
                        side: BorderSide(color: Colors.grey, width: 1.5),
                        textStyle: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      icon: Icon(Icons.edit, size: 18),
                      label: Text("Editar"),
                    ),
                    SizedBox(width: 12),
                    // Excluir
                    OutlinedButton.icon(
                      onPressed: () {
                        _confirmarExclusao(context, index);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[700],
                        side: BorderSide(color: Colors.red, width: 1.5),
                        textStyle: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      icon: Icon(Icons.delete_forever, size: 19),
                      label: Text("Excluir"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/perfil');
          }
        },
      ),
    );
  }

  String _formatDataHora(DateTime dt) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    return '${doisDigitos(dt.day)}/${doisDigitos(dt.month)}/${dt.year} ${doisDigitos(dt.hour)}:${doisDigitos(dt.minute)}';
  }

  void _editarManifestacao(BuildContext context, int index, Manifestacao m) {
    final controller = TextEditingController(text: m.texto);

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(
        0.35,
      ), // Overlay levemente escuro, sem tom rosado
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white, // Garantia de branco puro
          elevation: 2, // Bem baixo, quase sem sombra
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Row(
            children: [
              Icon(m.icon, color: Color(0xFF181883)),
              SizedBox(width: 7),
              Text(
                m.tipo,
                style: TextStyle(
                  color: Color(0xFF181883),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: TextField(
            controller: controller,
            maxLines: 5,
            maxLength: 500,
            style: TextStyle(color: Color(0xFF181883)),
            decoration: InputDecoration(
              hintText: 'Edite sua manifestação...',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
              ),
              counterStyle: TextStyle(color: Color(0xFF181883)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  manifestacoes[index] = manifestacoes[index].copyWith(
                    texto: controller.text,
                  );
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFD700),
                foregroundColor: Color(0xFF181883),
              ),
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _confirmarExclusao(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45), // Fundo borrado/escuro
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Tem certeza que deseja excluir sua manifestação?",
            style: TextStyle(
              color: Color(0xFF181883),
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Voltar"),
              style: TextButton.styleFrom(foregroundColor: Color(0xFF181883)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  manifestacoes.removeAt(index);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: Text("Excluir"),
            ),
          ],
        );
      },
    );
  }
}

class Manifestacao {
  final String tipo;
  final IconData icon;
  final String texto;
  final DateTime dataHora;

  Manifestacao({
    required this.tipo,
    required this.icon,
    required this.texto,
    required this.dataHora,
  });

  Manifestacao copyWith({
    String? tipo,
    IconData? icon,
    String? texto,
    DateTime? dataHora,
  }) {
    return Manifestacao(
      tipo: tipo ?? this.tipo,
      icon: icon ?? this.icon,
      texto: texto ?? this.texto,
      dataHora: dataHora ?? this.dataHora,
    );
  }
}
