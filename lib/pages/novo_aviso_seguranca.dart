// lib/pages/novo_aviso_seguranca.dart

import 'package:flutter/material.dart';
import '../widgets/modal_mensagem_pos_envio.dart';
import 'package:flutter/services.dart';

class NovoAvisoSegurancaPage extends StatefulWidget {
  const NovoAvisoSegurancaPage({Key? key}) : super(key: key);

  @override
  State<NovoAvisoSegurancaPage> createState() => _NovoAvisoSegurancaPageState();
}

class _NovoAvisoSegurancaPageState extends State<NovoAvisoSegurancaPage> {
  bool sobreCamera = false;
  bool sobreAlarme = false;
  final TextEditingController _controller = TextEditingController();

  static const int maxLength = 500;
  static const int minLength = 5;

  bool get _formValido =>
      (sobreCamera || sobreAlarme) &&
      _controller.text.trim().length >= minLength;

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
              'Aviso de Segurança',
              style: TextStyle(
                color: azul,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            _CheckBoxTile(
              value: sobreCamera,
              onChanged: (v) => setState(() => sobreCamera = v!),
              text: 'Sobre Câmera',
              azul: azul,
              laranja: laranja,
            ),
            const SizedBox(height: 16),
            _CheckBoxTile(
              value: sobreAlarme,
              onChanged: (v) => setState(() => sobreAlarme = v!),
              text: 'Sobre Alarme',
              azul: azul,
              laranja: laranja,
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Descreva seu Aviso de Segurança',
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
                  style: TextStyle(color: azul, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Digite aqui...',
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
