import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EsqueciSenhaPage extends StatefulWidget {
  @override
  _EsqueciSenhaPageState createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  final TextEditingController docController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String tipoDoc = 'CPF';
  String? mensagem;

  @override
  void initState() {
    super.initState();
    docController.addListener(_docListener);
  }

  @override
  void dispose() {
    docController.removeListener(_docListener);
    docController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _docListener() {
    String text = docController.text.replaceAll(RegExp(r'\D'), '');
    String formatted = _formatDoc(text);
    if (docController.text != formatted) {
      docController.value = docController.value.copyWith(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  String _formatDoc(String value) {
    if (tipoDoc == 'CPF') {
      if (value.length > 11) value = value.substring(0, 11);
      String out = '';
      for (int i = 0; i < value.length; i++) {
        if (i == 3 || i == 6) out += '.';
        if (i == 9) out += '-';
        out += value[i];
      }
      return out;
    } else {
      // CNPJ
      if (value.length > 14) value = value.substring(0, 14);
      String out = '';
      for (int i = 0; i < value.length; i++) {
        if (i == 2 || i == 5) out += '.';
        if (i == 8) out += '/';
        if (i == 12) out += '-';
        out += value[i];
      }
      return out;
    }
  }

  bool get docValido {
    final clean = docController.text.replaceAll(RegExp(r'\D'), '');
    if (tipoDoc == 'CPF') return clean.length == 11;
    return clean.length == 14;
  }

  void enviarRedefinicao() {
    final cleanDoc = docController.text.replaceAll(RegExp(r'\D'), '');
    final email = emailController.text.trim();
    if (!email.contains('@')) {
      setState(() {
        mensagem = 'Digite um e-mail válido.';
      });
      return;
    }
    // Só aceita CPF '12345678900' ou CNPJ '12345678000199' com email correto
    if ((tipoDoc == 'CPF' &&
            cleanDoc == '12345678900' &&
            email == 'cliente@protopac.com.br') ||
        (tipoDoc == 'CNPJ' &&
            cleanDoc == '12345678000199' &&
            email == 'cliente@protopac.com.br')) {
      setState(() {
        mensagem =
            'E-mail de redefinição enviado! Verifique sua caixa de entrada.';
      });
    } else {
      setState(() {
        mensagem = '$tipoDoc não compatível com cliente da Protepac.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final azul = Color(0xFF181883);
    final laranja = Color(0xFFFF9900);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: azul),
              onPressed: () => Navigator.pop(context),
            ),
            floating: false,
            pinned: false,
            snap: false,
            toolbarHeight: 54,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  // Dropdown CPF/CNPJ
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButton<String>(
                      value: tipoDoc,
                      underline: SizedBox(),
                      items: [
                        DropdownMenuItem(value: 'CPF', child: Text('CPF')),
                        DropdownMenuItem(value: 'CNPJ', child: Text('CNPJ')),
                      ],
                      onChanged: (value) {
                        if (value != null && value != tipoDoc) {
                          setState(() {
                            tipoDoc = value;
                            docController.clear();
                          });
                        }
                      },
                      style: TextStyle(
                        color: laranja,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      icon: Icon(Icons.arrow_drop_down, color: laranja),
                      dropdownColor: Colors.white,
                    ),
                  ),
                  TextField(
                    controller: docController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        tipoDoc == 'CPF' ? 11 : 14,
                      ),
                    ],
                    onChanged: (value) {
                      String text = value.replaceAll(RegExp(r'\D'), '');
                      String formatted = _formatDoc(text);
                      if (docController.text != formatted) {
                        docController.value = TextEditingValue(
                          text: formatted,
                          selection: TextSelection.collapsed(
                            offset: formatted.length,
                          ),
                        );
                      }
                    },
                    style: TextStyle(color: azul),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2.2,
                        ),
                      ),
                      hintText: tipoDoc == 'CPF'
                          ? '000.000.000-00'
                          : '00.000.000/0000-00',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: laranja,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: azul),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Color(0xFFFFD700),
                          width: 2.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: enviarRedefinicao,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD700),
                        foregroundColor: azul,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.2,
                        ),
                      ),
                      child: Text('Enviar'),
                    ),
                  ),
                  if (mensagem != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 4.0),
                      child: Text(
                        mensagem!,
                        style: TextStyle(color: azul, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
