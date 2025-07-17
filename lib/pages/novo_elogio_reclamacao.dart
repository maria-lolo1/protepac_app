// lib/pages/novo_elogio_reclamacao.dart

import 'package:flutter/material.dart';
import '../widgets/modal_mensagem_pos_envio.dart';
import 'package:flutter/services.dart';

class NovoElogioReclamacaoPage extends StatefulWidget {
  const NovoElogioReclamacaoPage({Key? key}) : super(key: key);

  @override
  State<NovoElogioReclamacaoPage> createState() =>
      _NovoElogioReclamacaoPageState();
}

class _NovoElogioReclamacaoPageState extends State<NovoElogioReclamacaoPage> {
  String? tipoSelecionado; // 'elogio' ou 'reclamacao'
  final TextEditingController _controller = TextEditingController();
  static const int maxLength = 500;
  static const int minLength = 5;

  bool get _formValido =>
      tipoSelecionado != null && _controller.text.trim().length >= minLength;

  void _enviar() {
    if (_controller.text.trim().length < minLength) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ModalMensagemPosEnvio(
          tipo: MensagemPosEnvioTipo.faltando, // <-- Corrija aqui!
          mensagemCustomizada:
              'Por favor, escreva pelo menos $minLength caracteres.',
          onVoltar: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ModalMensagemPosEnvio(
        tipo: MensagemPosEnvioTipo.sucesso,
        mensagemCustomizada:
            'Agradecemos pela mensagem! Nossa equipe vai avaliar seu feedback e qualquer coisa entrará em contato.',
        onVerManif: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushReplacementNamed('/minhas_manifestacoes');
        },
        onProsseguir: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushReplacementNamed('/home');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final azul = Color(0xFF181883);
    final laranja = Color(0xFFFF9900);

    String hint;
    if (tipoSelecionado == 'elogio') {
      hint = 'Digite seu elogio aqui...';
    } else if (tipoSelecionado == 'reclamacao') {
      hint = 'Digite sua reclamação aqui...';
    } else {
      hint = 'Digite aqui...';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: false,
            floating: false,
            expandedHeight: 70,
            flexibleSpace: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: azul),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Por gentileza, escreva seu elogio ou reclamação, que nossa equipe irá receber e analisar seu feedback.',
                    style: TextStyle(
                      color: azul,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _ManifestacaoRadioCheckTile(
                    selecionado: tipoSelecionado == 'elogio',
                    onTap: () {
                      setState(() {
                        tipoSelecionado = 'elogio';
                        _controller.clear();
                      });
                    },
                    texto: 'Elogio',
                    azul: azul,
                    laranja: laranja,
                  ),
                  const SizedBox(height: 16),
                  _ManifestacaoRadioCheckTile(
                    selecionado: tipoSelecionado == 'reclamacao',
                    onTap: () {
                      setState(() {
                        tipoSelecionado = 'reclamacao';
                        _controller.clear();
                      });
                    },
                    texto: 'Reclamação',
                    azul: azul,
                    laranja: laranja,
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Deixe sua mensagem para a Protepac',
                      style: TextStyle(
                        color: laranja,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      TextField(
                        controller: _controller,
                        minLines: 5,
                        maxLines: 16,
                        maxLength: maxLength,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        enabled: tipoSelecionado != null,
                        style: TextStyle(color: azul, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: TextStyle(color: Color(0xFF181883)),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: laranja, width: 2),
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
                          contentPadding: EdgeInsets.fromLTRB(24, 12, 24, 45),
                          counterText: '',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      Positioned(
                        bottom: 11,
                        right: 17,
                        child: Text(
                          '${_controller.text.length}/$maxLength',
                          style: TextStyle(fontSize: 12, color: azul),
                        ),
                      ),
                      if (_controller.text.isNotEmpty &&
                          _controller.text.length < minLength)
                        Positioned(
                          bottom: 11,
                          left: 16,
                          child: Text(
                            'Mínimo $minLength caracteres',
                            style: TextStyle(
                              fontSize: 12,
                              color: azul,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: laranja,
                            foregroundColor: azul,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _formValido ? _enviar : null,
                          child: const Text('Enviar'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ManifestacaoRadioCheckTile extends StatelessWidget {
  final bool selecionado;
  final VoidCallback onTap;
  final String texto;
  final Color azul;
  final Color laranja;

  const _ManifestacaoRadioCheckTile({
    required this.selecionado,
    required this.onTap,
    required this.texto,
    required this.azul,
    required this.laranja,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(
              color: laranja, // Sempre amarela
              width: 2, // Fino igual ao exemplo 2
            ),
            borderRadius: BorderRadius.circular(8), // Cantos menos arredondados
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(width: 15),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selecionado
                        ? laranja
                        : Color(
                            0xFF47465A,
                          ), // cinza escuro só na caixinha // Sempre amarela
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  color: selecionado ? laranja : Colors.white,
                ),
                child: selecionado
                    ? Icon(Icons.check, color: azul, size: 18)
                    : null,
              ),
              SizedBox(width: 15),
              Text(
                texto,
                style: TextStyle(
                  color: azul,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
