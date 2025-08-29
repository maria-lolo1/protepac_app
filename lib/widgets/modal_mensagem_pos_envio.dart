import 'package:flutter/material.dart';

enum MensagemPosEnvioTipo { sucesso, erro, faltando }

class ModalMensagemPosEnvio extends StatelessWidget {
  final MensagemPosEnvioTipo tipo;
  final VoidCallback? onVerManif;
  final VoidCallback? onProsseguir;
  final VoidCallback? onTentarNovamente;
  final VoidCallback? onVoltar;
  final String? mensagemCustomizada;

  const ModalMensagemPosEnvio({
    Key? key,
    required this.tipo,
    this.onVerManif,
    this.onProsseguir,
    this.onTentarNovamente,
    this.onVoltar,
    this.mensagemCustomizada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary =
        theme.colorScheme.primary; // azul no claro, laranja no escuro
    final secondary =
        theme.colorScheme.secondary; // laranja no claro, amarelo no escuro
    final background =
        theme.dialogBackgroundColor; // branco/claro ou preto/escuro

    String mensagem = '';
    Widget botoesWidget;

    if (tipo == MensagemPosEnvioTipo.sucesso) {
      mensagem =
          mensagemCustomizada ??
          'Agradecemos pela mensagem! Nossa equipe comercial entrará em contato em breve.';

      botoesWidget = LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 380) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ModalButton(
                  texto: 'Ver Manifestações',
                  corBorda: primary,
                  corTexto: secondary,
                  onPressed: onVerManif,
                ),
                const SizedBox(height: 12),
                _ModalButton(
                  texto: 'Prosseguir',
                  corBorda: secondary,
                  corTexto: primary,
                  onPressed: onProsseguir,
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ModalButton(
                  texto: 'Ver Manifestações',
                  corBorda: primary,
                  corTexto: secondary,
                  onPressed: onVerManif,
                ),
                const SizedBox(width: 12),
                _ModalButton(
                  texto: 'Prosseguir',
                  corBorda: secondary,
                  corTexto: primary,
                  onPressed: onProsseguir,
                ),
              ],
            );
          }
        },
      );
    } else if (tipo == MensagemPosEnvioTipo.erro) {
      mensagem = 'Erro ao enviar sua mensagem!';
      botoesWidget = Center(
        child: _ModalButton(
          texto: 'Tentar Novamente',
          corBorda: secondary,
          corTexto: primary,
          onPressed: onTentarNovamente,
        ),
      );
    } else {
      mensagem = 'Preencher os dados obrigatórios!';
      botoesWidget = SizedBox(
        width: double.infinity,
        child: _ModalButton(
          texto: 'Voltar',
          corBorda: secondary,
          corTexto: primary,
          onPressed: onVoltar,
        ),
      );
    }

    return Dialog(
      backgroundColor: background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mensagem,
              style: TextStyle(
                color: primary,
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
        backgroundColor: Theme.of(context).dialogBackgroundColor,
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
