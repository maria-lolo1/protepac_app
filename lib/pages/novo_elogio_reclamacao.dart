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
    if (!_formValido) {
      showDialog(
        context: context,
        builder: (_) => ModalMensagemPosEnvio(
          tipo: MensagemPosEnvioTipo.faltando,
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: azul),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 120, fit: BoxFit.contain),
            const SizedBox(height: 32),

            // Caixinhas personalizadas para Elogio e Reclamação
            _OpcaoManifestacaoTile(
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
            const SizedBox(height: 10),
            _OpcaoManifestacaoTile(
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
            // Título acima da caixa de mensagem (padrão das outras telas)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Escreva sua mensagem',
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
                    hintStyle: TextStyle(color: Color(0xFF999999)),
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
            const SizedBox(height: 30),
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
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _OpcaoManifestacaoTile extends StatelessWidget {
  final bool selecionado;
  final VoidCallback onTap;
  final String texto;
  final Color azul;
  final Color laranja;

  const _OpcaoManifestacaoTile({
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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            border: Border.all(
              color: selecionado ? laranja : laranja.withOpacity(0.5),
              width: selecionado ? 2.5 : 1.7,
            ),
            borderRadius: BorderRadius.circular(12),
            color: selecionado ? laranja.withOpacity(0.10) : Colors.white,
          ),
          child: Row(
            children: [
              Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selecionado ? laranja : Colors.grey[400]!,
                    width: selecionado ? 2.2 : 1.4,
                  ),
                  color: selecionado ? laranja : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: selecionado
                    ? Icon(Icons.check, size: 18, color: azul)
                    : null,
              ),
              SizedBox(width: 12),
              Text(
                texto,
                style: TextStyle(
                  color: azul,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
