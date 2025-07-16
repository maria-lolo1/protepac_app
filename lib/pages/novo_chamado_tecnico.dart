// lib/pages/novo_chamado_tecnico.dart

import 'package:flutter/material.dart';
import '../widgets/modal_mensagem_pos_envio.dart';

class NovoChamadoTecnicoPage extends StatefulWidget {
  const NovoChamadoTecnicoPage({Key? key}) : super(key: key);

  @override
  State<NovoChamadoTecnicoPage> createState() => _NovoChamadoTecnicoPageState();
}

class _NovoChamadoTecnicoPageState extends State<NovoChamadoTecnicoPage> {
  bool cftv = false;
  bool alarme = false;
  bool enviando = false;

  void _enviar() {
    if (!cftv && !alarme) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder:
            (
              BuildContext buildContext,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return Center(
                child: ModalMensagemPosEnvio(
                  tipo: MensagemPosEnvioTipo.faltando,
                  onVoltar: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                ),
              );
            },
      );
      return;
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder:
          (
            BuildContext buildContext,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return Center(
              child: ModalMensagemPosEnvio(
                tipo: MensagemPosEnvioTipo.sucesso,
                onVerManif: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  // Aqui já está seguro navegar direto
                  Navigator.of(
                    context,
                  ).pushReplacementNamed('/minhas_manifestacoes');
                },
                onProsseguir: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
            );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    final azul = Color(0xFF181883);
    final laranja = Color(0xFFFF9900);

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
            const SizedBox(height: 24),
            Text(
              'Por gentileza especifique sua necessidade que a nossa equipe entrará em contato',
              style: TextStyle(
                color: azul,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            _CheckBoxTile(
              value: cftv,
              onChanged: (val) => setState(() => cftv = val!),
              text: 'CFTV',
              azul: azul,
              laranja: laranja,
            ),
            const SizedBox(height: 20),
            _CheckBoxTile(
              value: alarme,
              onChanged: (val) => setState(() => alarme = val!),
              text: 'Alarme',
              azul: azul,
              laranja: laranja,
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
                    onPressed: _enviar, // só chama sua função simples
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

class _CheckBoxTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;
  final Color azul;
  final Color laranja;

  const _CheckBoxTile({
    required this.value,
    required this.onChanged,
    required this.text,
    required this.azul,
    required this.laranja,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: laranja, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          text,
          style: TextStyle(
            color: azul,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        activeColor: laranja,
        checkColor: azul,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
