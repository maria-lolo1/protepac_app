import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protepac/widgets/bottom_navbar_geral.dart';

// Para navegação: Navigator.pushNamed(context, '/manifestacoes_geral', arguments: {'role': 'adm'});
// Ou: {'role': 'funcionario'}

class ManifestacoesGeralPage extends StatefulWidget {
  @override
  State<ManifestacoesGeralPage> createState() => _ManifestacoesGeralPageState();
}

class _ManifestacoesGeralPageState extends State<ManifestacoesGeralPage> {
  List<Manifestacao> manifestacoes = [
    Manifestacao(
      tipo: 'Elogio',
      icon: Icons.thumb_up_alt_rounded,
      texto: 'Equipe atenciosa, resolveram tudo com rapidez!',
      dataHora: DateTime(2025, 7, 16, 18, 33),
      visto: false,
      email: 'teste1@email.com',
    ),
    Manifestacao(
      tipo: 'Reclamação',
      icon: Icons.thumb_down_alt_rounded,
      texto: 'Fiquei aguardando retorno e não fui atendido.',
      dataHora: DateTime(2025, 7, 15, 9, 15),
      visto: false,
      email: 'teste2@email.com',
    ),
    Manifestacao(
      tipo: 'Chamado técnico',
      icon: Icons.build_circle_rounded,
      texto: 'CFTV - Imagens da câmera frontal estão fora do ar.',
      dataHora: DateTime(2025, 7, 14, 14, 55),
      visto: true,
      email: 'teste3@email.com',
    ),
    Manifestacao(
      tipo: 'Aviso Segurança',
      icon: Icons.security_rounded,
      texto:
          'Câmera - Câmera da frente apresentou alerta de movimento suspeito.',
      dataHora: DateTime(2025, 7, 13, 11, 25),
      visto: true,
      email: 'teste4@email.com',
    ),
    Manifestacao(
      tipo: 'Solic. Orçamento',
      icon: Icons.request_page_rounded,
      texto:
          'Alarme - Gostaria de orçamento para ampliação do sistema de alarme.',
      dataHora: DateTime(2025, 7, 12, 10, 12),
      visto: true,
      email: 'teste5@email.com',
    ),
    Manifestacao(
      tipo: 'Indicação Cliente',
      icon: Icons.person_add_alt_1_rounded,
      texto: 'Maria Silva Pereira - 51996756445\nCFTV - Comercial.',
      dataHora: DateTime(2025, 7, 11, 13, 44),
      visto: false,
      email: 'teste6@email.com',
    ),
    Manifestacao(
      tipo: 'Sugestão',
      icon: Icons.lightbulb_outline_rounded,
      texto: 'Poderiam adicionar notificações por WhatsApp.',
      dataHora: DateTime(2025, 7, 10, 15, 55),
      visto: true,
      email: 'teste7@email.com',
    ),
  ];

  String _role = "usuario"; // padrão
  bool get isAdm => _role == "adm";
  bool get isFuncionario => _role == "funcionario";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null && args['role'] != null) {
      _role = args['role'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Manifestações dos Usuários',
                    style: TextStyle(
                      color: azul,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            sliver: SliverList.separated(
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
                      Row(
                        children: [
                          Icon(m.icon, color: azul),
                          SizedBox(width: 7),
                          Text(
                            m.tipo,
                            style: TextStyle(
                              color: azul,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Spacer(),
                          Text(
                            _formatDataHora(m.dataHora),
                            style: TextStyle(
                              color: laranja,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        m.texto,
                        style: TextStyle(color: laranja, fontSize: 15),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          // EDITAR (ADM apenas)
                          Container(
                            width: 55,
                            height: 50,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: isAdm ? Colors.grey : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              onPressed: isAdm
                                  ? () => _editarManifestacao(context, index, m)
                                  : null,
                              icon: Icon(
                                Icons.edit,
                                color: isAdm
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                                size: 30,
                              ),
                              tooltip: 'Editar',
                              splashRadius: 26,
                            ),
                          ),
                          SizedBox(width: 16),
                          // EXCLUIR (ADM apenas)
                          Container(
                            width: 55,
                            height: 50,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: isAdm
                                    ? Colors.red[700]!
                                    : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              onPressed: isAdm
                                  ? () => _confirmarExclusao(context, index)
                                  : null,
                              icon: Icon(
                                Icons.delete_forever,
                                color: isAdm
                                    ? Colors.red[700]
                                    : Colors.grey[300],
                                size: 30,
                              ),
                              tooltip: 'Excluir',
                              splashRadius: 26,
                            ),
                          ),
                          SizedBox(width: 16),
                          // GMAIL (ADM/FUNCIONARIO, copia email)
                          Container(
                            width: 55,
                            height: 50,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.orange[800]!,
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              onPressed: m.email.isNotEmpty
                                  ? () {
                                      Clipboard.setData(
                                        ClipboardData(text: m.email),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('Email copiado!'),
                                        ),
                                      );
                                    }
                                  : null,
                              icon: Icon(
                                Icons.mail_outline,
                                color: Colors.orange[800],
                                size: 30,
                              ),
                              tooltip: 'Copiar email do usuário',
                              splashRadius: 26,
                            ),
                          ),
                          SizedBox(width: 16),
                          // STATUS (visto/pendente)
                          Container(
                            width: 55,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: m.visto
                                    ? Colors.green
                                    : Color(0xFFFF9900),
                                width: 2.2,
                              ),
                            ),
                            child: IconButton(
                              onPressed: (isAdm || isFuncionario)
                                  ? () {
                                      setState(() {
                                        manifestacoes[index] =
                                            manifestacoes[index].copyWith(
                                              visto: !m.visto,
                                            );
                                      });
                                    }
                                  : null,
                              icon: Icon(
                                m.visto
                                    ? Icons.check_circle
                                    : Icons.hourglass_bottom,
                                color: m.visto
                                    ? Colors.green
                                    : Color(0xFFFF9900),
                                size: 30,
                              ),
                              tooltip: m.visto ? 'Visto' : 'Pendente',
                              splashRadius: 26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 26)),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBarGeral(
        selectedIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/manifestacoes_geral');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }

  Widget _buildMiniButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color borderColor,
    required VoidCallback? onTap,
    bool enabled = true,
    double iconSize =
        30, // <-- Adicione esse parâmetro com valor igual ao status!
  }) {
    final Color effectiveColor = enabled ? color : Colors.grey[400]!;
    final Color effectiveBorder = enabled ? borderColor : Colors.grey[300]!;

    return OutlinedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: iconSize, color: effectiveColor), // aqui!
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: effectiveColor,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: effectiveColor,
        side: BorderSide(color: effectiveBorder, width: 1.2),
        textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        minimumSize: Size(0, 32),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        disabledForegroundColor: Colors.grey[400],
        disabledBackgroundColor: Colors.white,
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
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 2,
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
      barrierColor: Colors.black.withOpacity(0.45),
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
  final bool visto;
  final String email; // novo campo

  Manifestacao({
    required this.tipo,
    required this.icon,
    required this.texto,
    required this.dataHora,
    required this.visto,
    required this.email, // novo campo
  });

  Manifestacao copyWith({
    String? tipo,
    IconData? icon,
    String? texto,
    DateTime? dataHora,
    bool? visto,
    String? email,
  }) {
    return Manifestacao(
      tipo: tipo ?? this.tipo,
      icon: icon ?? this.icon,
      texto: texto ?? this.texto,
      dataHora: dataHora ?? this.dataHora,
      visto: visto ?? this.visto,
      email: email ?? this.email,
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  BottomNavItem({required this.icon, required this.label, required this.onTap});
}
