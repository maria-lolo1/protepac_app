import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimeiroLoginPage extends StatefulWidget {
  @override
  _PrimeiroLoginPageState createState() => _PrimeiroLoginPageState();
}

class _PrimeiroLoginPageState extends State<PrimeiroLoginPage> {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  bool _obscureSenha = true;
  bool _obscureConfirmSenha = true; // Declare no seu State

  String? estado; // null, 'pode_redefinir'
  String mensagem = '';
  String nivelSenha = '';

  // CPF formatter: ###.###.###-##
  String _formatCpf(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length > 11) value = value.substring(0, 11);
    String out = '';
    for (int i = 0; i < value.length; i++) {
      if (i == 3 || i == 6) out += '.';
      if (i == 9) out += '-';
      out += value[i];
    }
    return out;
  }

  // Senha strength
  String _nivelSenha(String senha) {
    if (senha.length < 4) return "Muito fraca";
    bool hasUpper = senha.contains(RegExp(r'[A-Z]'));
    bool hasLower = senha.contains(RegExp(r'[a-z]'));
    bool hasDigit = senha.contains(RegExp(r'\d'));
    bool hasSpecial = senha.contains(RegExp(r'[^A-Za-z0-9]'));

    int score = 0;
    if (hasUpper) score++;
    if (hasLower) score++;
    if (hasDigit) score++;
    if (hasSpecial) score++;
    if (senha.length >= 8) score++;

    if (score <= 1) return "Fraca";
    if (score == 2) return "Média";
    if (score == 3) return "Forte";
    if (score >= 4) return "Muito forte";
    return "Muito fraca";
  }

  bool get cpfValido =>
      cpfController.text.replaceAll(RegExp(r'\D'), '').length == 11;

  @override
  void initState() {
    super.initState();
    cpfController.addListener(() {
      final formatted = _formatCpf(cpfController.text);
      if (formatted != cpfController.text) {
        cpfController.value = cpfController.value.copyWith(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
      setState(() {});
    });
    senhaController.addListener(() {
      setState(() {
        nivelSenha = _nivelSenha(senhaController.text);
      });
    });
  }

  @override
  void dispose() {
    cpfController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
    super.dispose();
  }

  void verificarCpf() {
    if (!cpfValido) {
      setState(() {
        mensagem = 'Preencha o CPF corretamente!';
      });
      return;
    }
    // Aceita qualquer CPF preenchido (mock)
    setState(() {
      estado = 'pode_redefinir';
      mensagem = '';
    });
  }

  void redefinirSenha() {
    if (senhaController.text != confirmaSenhaController.text) {
      setState(() {
        mensagem = "As senhas não coincidem.";
      });
      return;
    }
    if (senhaController.text.length < 4) {
      setState(() {
        mensagem = "A senha é muito curta.";
      });
      return;
    }
    // Mock: senha aceita
    setState(() {
      mensagem = "Senha cadastrada com sucesso! Faça login.";
    });
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset('assets/logo.png', height: 120, fit: BoxFit.contain),
            const SizedBox(height: 30),
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
              enabled: estado == null,
              style: TextStyle(color: Color(0xFF181883)),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // só números
                LengthLimitingTextInputFormatter(11), // no máximo 11 dígitos
              ],
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
                hintText: '000.000.000-00',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                String text = value.replaceAll(RegExp(r'\D'), '');
                String formatted = '';
                for (int i = 0; i < text.length; i++) {
                  if (i == 3 || i == 6) formatted += '.';
                  if (i == 9) formatted += '-';
                  formatted += text[i];
                }
                if (formatted != cpfController.text) {
                  cpfController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            if (estado == null)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: cpfValido ? verificarCpf : null,
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
                  child: Text('VERIFICAR'),
                ),
              ),
            if (estado == 'pode_redefinir') ...[
              const SizedBox(height: 4),
              // NOVA SENHA
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nova Senha',
                    style: TextStyle(
                      color: Color(0xFFFF9900),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: senhaController,
                    obscureText: _obscureSenha,
                    onChanged: (_) => setState(() {}),
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureSenha
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF181883),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureSenha = !_obscureSenha;
                          });
                        },
                      ),
                    ),
                  ),
                  if (senhaController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        left: 4,
                        bottom: 10,
                      ),
                      child: Text(
                        'Nível da senha: $nivelSenha',
                        style: TextStyle(
                          color:
                              (nivelSenha == "Muito fraca" ||
                                  nivelSenha == "Fraca")
                              ? Colors.red
                              : nivelSenha == "Média"
                              ? Colors.blue
                              : Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirme sua Senha',
                  style: TextStyle(
                    color: Color(0xFFFF9900),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Campo Confirmar senha + mensagem
              TextField(
                controller: confirmaSenhaController,
                obscureText: _obscureConfirmSenha,
                onChanged: (_) => setState(() {}),
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
                    borderSide: BorderSide(
                      color: Color(0xFFFFD700),
                      width: 2.2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmSenha
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xFF181883),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmSenha = !_obscureConfirmSenha;
                      });
                    },
                  ),
                ),
              ),

              if (confirmaSenhaController.text.isNotEmpty &&
                  senhaController.text != confirmaSenhaController.text)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Senhas não coincidem",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed:
                      (senhaController.text == confirmaSenhaController.text &&
                          senhaController.text.isNotEmpty &&
                          (nivelSenha == "Média" ||
                              nivelSenha == "Forte" ||
                              nivelSenha == "Muito forte"))
                      ? redefinirSenha
                      : null,
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
                  child: Text('REDEFINIR SENHA'),
                ),
              ),
            ],
            if (mensagem.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                child: Text(
                  mensagem,
                  style: TextStyle(color: Color(0xFF181883), fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
