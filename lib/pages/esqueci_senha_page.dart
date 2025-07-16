import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EsqueciSenhaPage extends StatefulWidget {
  @override
  _EsqueciSenhaPageState createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? mensagem;

  @override
  void initState() {
    super.initState();
    cpfController.addListener(_cpfListener);
  }

  void _cpfListener() {
    String text = cpfController.text.replaceAll(RegExp(r'\D'), '');
    if (text.length > 11) text = text.substring(0, 11);
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) formatted += '.';
      if (i == 9) formatted += '-';
      formatted += text[i];
    }
    if (cpfController.text != formatted) {
      cpfController.value = cpfController.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void enviarRedefinicao() {
    final cleanCpf = cpfController.text.replaceAll(RegExp(r'\D'), '');
    final email = emailController.text.trim();
    if (!email.contains('@')) {
      setState(() {
        mensagem = 'Digite um e-mail válido.';
      });
      return;
    }
    // Só aceita CPF '12345678900' e email 'cliente@protopac.com.br'
    if (cleanCpf == '12345678900' && email == 'cliente@protopac.com.br') {
      setState(() {
        mensagem =
            'E-mail de redefinição enviado! Verifique sua caixa de entrada.';
      });
    } else {
      setState(() {
        mensagem = 'CPF não compatível com cliente da Protepac.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF181883)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true, // Pode deixar, é padrão
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo grudada no topo
            SizedBox(height: 10),
            Image.asset('assets/logo.png', height: 120, fit: BoxFit.contain),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CPF',
                style: TextStyle(
                  color: Color(0xFFFF9900),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: cpfController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11), // Só 11 dígitos
                // Você pode usar um formatter de CPF se preferir
              ],
              onChanged: (value) {
                // Formatação automática: 123.456.789-01
                String text = value.replaceAll(RegExp(r'\D'), '');
                if (text.length > 11) text = text.substring(0, 11);
                String formatted = '';
                for (int i = 0; i < text.length; i++) {
                  if (i == 3 || i == 6) formatted += '.';
                  if (i == 9) formatted += '-';
                  formatted += text[i];
                }
                if (cpfController.text != formatted) {
                  cpfController.value = cpfController.value.copyWith(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
              },
              style: TextStyle(color: Color(0xFF181883)), // Azul digitando
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'E-mail',
                style: TextStyle(
                  color: Color(0xFFFF9900),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Color(0xFF181883)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: enviarRedefinicao,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Color(0xFF181883),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.2,
                  ),
                ),
                child: Text('ENVIAR'),
              ),
            ),
            if (mensagem != null)
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 4.0),
                child: Text(
                  mensagem!,
                  style: TextStyle(color: Color(0xFF181883), fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            // Removido o botão VOLTAR!
          ],
        ),
      ),
    );
  }
}
