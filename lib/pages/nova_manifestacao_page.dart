import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NovaManifestacaoPage extends StatefulWidget {
  final String tipo;
  const NovaManifestacaoPage({Key? key, required this.tipo}) : super(key: key);

  @override
  State<NovaManifestacaoPage> createState() => _NovaManifestacaoPageState();
}

class _NovaManifestacaoPageState extends State<NovaManifestacaoPage> {
  final TextEditingController _controller = TextEditingController();
  static const int maxLength = 500;
  static const int minLength = 5;

  final Map<String, String> titulos = {
    'elogio': 'Escreva seu Elogio sobre a Protepac',
    'reclamacao': 'Escreva sua Reclamação sobre a Protepac',
    'chamado': 'Abertura de Chamado Técnico',
    'avisos': 'Avisos de Segurança',
    'ouvidoria': 'Escreva para a Ouvidoria da Protepac',
    'indicacao': 'Indicação de Novo Cliente',
    'sugestao': 'Escreva sua Sugestão para a Protepac',
  };

  @override
  Widget build(BuildContext context) {
    final titulo = titulos[widget.tipo] ?? 'Nova Manifestação';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF181883)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/logo.png', height: 90)),
              const SizedBox(height: 50),
              // Título alinhado à esquerda, cor laranja
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 6),
                child: Text(
                  titulo,
                  style: TextStyle(
                    color: Color(0xFFFF9900),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 8),
              // Caixa de texto grande
              Stack(
                children: [
                  TextField(
                    controller: _controller,
                    minLines: 5,
                    maxLines: 16,
                    maxLength: maxLength,
                    maxLengthEnforcement:
                        MaxLengthEnforcement.enforced, // <-- Adicione isso
                    style: TextStyle(color: Color(0xFF181883), fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Digite aqui...',
                      hintStyle: TextStyle(color: Color(0xFF999999)),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide(
                          color: Color(0xFFFF9900), // Laranja
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2.1,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(
                        24, // left
                        12, // top
                        24, // right (aumente!)
                        45, // bottom (aumente!)
                      ), // left, top, right, bottom
                      counterText: '',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  // Contador caracteres no canto inferior direito DENTRO da caixa
                  Positioned(
                    bottom: 11,
                    right: 17,
                    child: Text(
                      '${_controller.text.length}/500',
                      style: TextStyle(fontSize: 12, color: Color(0xFF181883)),
                    ),
                  ),
                  // Mínimo de caracteres avisar
                  if (_controller.text.isNotEmpty &&
                      _controller.text.length < minLength)
                    Positioned(
                      bottom: 11,
                      left: 16,
                      child: Text(
                        'Mínimo $minLength caracteres',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF181883),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // Botão ENVIAR alinhado à esquerda
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF9900),
                      foregroundColor: Color(0xFF181883),
                      padding: EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 12,
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _controller.text.trim().length < minLength
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Manifestação enviada com sucesso!',
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          },
                    child: Text('Enviar'),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
