// lib/widgets/modal_mensagem_pos_envio.dart

import 'package:flutter/material.dart';

enum MensagemPosEnvioTipo { sucesso, erro, faltando }

class ModalMensagemPosEnvio extends StatelessWidget {
  final MensagemPosEnvioTipo tipo;
  final VoidCallback? onVerManif;
  final VoidCallback? onProsseguir;
  final VoidCallback? onTentarNovamente;
  final VoidCallback? onVoltar;

  const ModalMensagemPosEnvio({
    Key? key,
    required this.tipo,
    this.onVerManif,
    this.onProsseguir,
    this.onTentarNovamente,
    this.onVoltar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mensagem = '';
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFFA500);

    Widget botoesWidget;

    // Layout responsivo para os botões de sucesso
    if (tipo == MensagemPosEnvioTipo.sucesso) {
      mensagem =
          'Agradecemos pela mensagem! Nossa equipe comercial entrará em contato em breve.';

      botoesWidget = LayoutBuilder(
        builder: (context, constraints) {
          // Em telas pequenas, empilha um embaixo do outro
          if (constraints.maxWidth < 380) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ModalButton(
                  texto: 'Ver Manifestações',
                  corBorda: azul,
                  corTexto: laranja,
                  onPressed: onVerManif,
                ),
                const SizedBox(height: 12),
                _ModalButton(
                  texto: 'Prosseguir',
                  corBorda: laranja,
                  corTexto: azul,
                  onPressed: onProsseguir,
                ),
              ],
            );
          } else {
            // Em telas grandes, botões lado a lado
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ModalButton(
                  texto: 'Ver Manifestações',
                  corBorda: azul,
                  corTexto: laranja,
                  onPressed: onVerManif,
                ),
                const SizedBox(width: 12),
                _ModalButton(
                  texto: 'Prosseguir',
                  corBorda: laranja,
                  corTexto: azul,
                  onPressed: onProsseguir,
                ),
              ],
            );
          }
        },
      );
    } else if (tipo == MensagemPosEnvioTipo.erro) {
      mensagem = 'Erro ao enviar sua mensagem!';
      botoesWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ModalButton(
            texto: 'Tentar Novamente',
            corBorda: laranja,
            corTexto: azul,
            onPressed: onTentarNovamente,
          ),
        ],
      );
    } else {
      mensagem = 'Preencher os dados obrigatórios!';
      botoesWidget = SizedBox(
        width: double.infinity,
        child: _ModalButton(
          texto: 'Voltar',
          corBorda: laranja,
          corTexto: azul,
          onPressed: onVoltar,
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mensagem,
              style: TextStyle(
                color: azul,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            botoesWidget,
          ],
        ),
      ),
    );
  }
}

class _ModalButton extends StatelessWidget {
  final String texto;
  final Color corBorda;
  final Color corTexto;
  final VoidCallback? onPressed;
  const _ModalButton({
    required this.texto,
    required this.corBorda,
    required this.corTexto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: corTexto,
        side: BorderSide(color: corBorda, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        texto,
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
