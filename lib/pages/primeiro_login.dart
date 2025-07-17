import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimeiroLoginPage extends StatefulWidget {
  @override
  _PrimeiroLoginPageState createState() => _PrimeiroLoginPageState();
}

class _PrimeiroLoginPageState extends State<PrimeiroLoginPage> {
  String tipoDoc = 'CPF';
  final TextEditingController docController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  bool _obscureSenha = true;
  bool _obscureConfirmSenha = true;

  String? estado;
  String mensagem = '';
  String nivelSenha = '';

  String _formatDoc(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
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

  bool get docValido {
    final val = docController.text.replaceAll(RegExp(r'\D'), '');
    if (tipoDoc == 'CPF') return val.length == 11;
    return val.length == 14;
  }

  bool get emailValido =>
      emailController.text.contains('@') && emailController.text.contains('.');

  bool get nomeValido => nomeController.text.trim().length >= 3;

  @override
  void initState() {
    super.initState();
    docController.addListener(() {
      final formatted = _formatDoc(docController.text);
      if (formatted != docController.text) {
        docController.value = docController.value.copyWith(
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
    docController.dispose();
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
    super.dispose();
  }

  void verificarDoc() {
    if (!docValido) {
      setState(() {
        mensagem = tipoDoc == 'CPF'
            ? 'Preencha o CPF corretamente!'
            : 'Preencha o CNPJ corretamente!';
      });
      return;
    }
    setState(() {
      estado = 'pode_redefinir';
      mensagem = '';
    });
  }

  void redefinirSenha() {
    if (!nomeValido) {
      setState(() {
        mensagem = "Preencha o nome completo.";
      });
      return;
    }
    if (!emailValido) {
      setState(() {
        mensagem = "Preencha um e-mail válido.";
      });
      return;
    }
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
    setState(() {
      mensagem = "Cadastro Realizado com Sucesso! Faça Login.";
    });
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  // Dropdown CPF/CNPJ (agora substitui o label)
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
                        color: laranja, // mesma cor do label antigo!
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
                    enabled: estado == null,
                    style: TextStyle(color: azul),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        tipoDoc == 'CPF' ? 11 : 14,
                      ),
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
                    onChanged: (value) {
                      String text = value.replaceAll(RegExp(r'\D'), '');
                      String formatted = _formatDoc(text);
                      if (formatted != docController.text) {
                        docController.value = TextEditingValue(
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
                        onPressed: docValido ? verificarDoc : null,
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
                        child: Text('Verificar'),
                      ),
                    ),
                  if (estado == 'pode_redefinir') ...[
                    // Nome Completo
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome Completo',
                          style: TextStyle(
                            color: laranja,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: nomeController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
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
                            hintText: 'Digite seu nome completo',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        if (nomeController.text.isNotEmpty && !nomeValido)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                              "Nome muito curto",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // EMAIL
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E-mail',
                          style: TextStyle(
                            color: laranja,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
                            hintText: 'Digite seu@email.com',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        if (emailController.text.isNotEmpty && !emailValido)
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 4),
                            child: Text(
                              "E-mail inválido",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // NOVA SENHA
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nova Senha',
                          style: TextStyle(
                            color: laranja,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: senhaController,
                          obscureText: _obscureSenha,
                          onChanged: (_) => setState(() {}),
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
                            hintText: 'Digite sua Nova Senha',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureSenha
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: azul,
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
                          color: laranja,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: confirmaSenhaController,
                      obscureText: _obscureConfirmSenha,
                      onChanged: (_) => setState(() {}),
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
                        hintText: 'Digite sua Senha',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmSenha
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: azul,
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
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            (senhaController.text ==
                                    confirmaSenhaController.text &&
                                senhaController.text.isNotEmpty &&
                                (nivelSenha == "Média" ||
                                    nivelSenha == "Forte" ||
                                    nivelSenha == "Muito forte") &&
                                emailValido &&
                                nomeValido)
                            ? redefinirSenha
                            : null,
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
                        child: Text('Cadastrar-se'),
                      ),
                    ),
                  ],
                  if (mensagem.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                      child: Text(
                        mensagem,
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
