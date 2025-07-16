import 'package:flutter/material.dart';

class PrimeiroLoginPage extends StatefulWidget {
  @override
  _PrimeiroLoginPageState createState() => _PrimeiroLoginPageState();
}

class _PrimeiroLoginPageState extends State<PrimeiroLoginPage> {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  String? estado; // 'sucesso', 'tem_senha', 'nao_cliente'
  String mensagem = '';

  void verificarCpf() {
    // Fluxo simulado:
    // 12345678900 = cliente novo (sucesso)
    // 99999999999 = já tem senha
    // qualquer outro = não cadastrado
    if (cpfController.text == '12345678900') {
      setState(() {
        estado = 'sucesso';
        mensagem = 'Verificação concluída com sucesso!';
      });
    } else if (cpfController.text == '99999999999') {
      setState(() {
        estado = 'tem_senha';
        mensagem = 'Já tem uma senha cadastrada nesse CPF.';
      });
    } else {
      setState(() {
        estado = 'nao_cliente';
        mensagem = 'CPF não cadastrado como cliente da Protopac.';
      });
    }
  }

  void confirmarCadastro() {
    if (senhaController.text.length < 4 || senhaController.text != confirmaSenhaController.text) {
      setState(() {
        mensagem = 'As senhas não coincidem ou são muito curtas.';
      });
    } else {
      setState(() {
        mensagem = 'Senha cadastrada com sucesso! Faça login.';
        estado = null;
      });
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 120,
                fit: BoxFit.contain,
              ),
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
                enabled: estado == null,
                style: TextStyle(color: Color(0xFF181883)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
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
              const SizedBox(height: 20),

              if (estado == null)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: verificarCpf,
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF181883), // azul do logo
                    foregroundColor: Color(0xFFFFD700), // amarelo
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                  child: Text('VOLTAR'),
                ),
              ),
              if (mensagem.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(
                    mensagem,
                    style: TextStyle(
                      color: Color(0xFF181883),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (estado == 'sucesso') ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nova Senha',
                    style: TextStyle(
                      color: Color(0xFFFF9900),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  style: TextStyle(color: Color(0xFF181883)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
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
                const SizedBox(height: 14),
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
                TextField(
                  controller: confirmaSenhaController,
                  obscureText: true,
                  style: TextStyle(color: Color(0xFF181883)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
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
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: confirmarCadastro,
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
                    child: Text('CONFIRMAR'),
                  ),
                ),
              ],
              if (estado == 'tem_senha')
                Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, '/esqueci_senha'),
                      child: Text(
                        'Redefinir senha',
                        style: TextStyle(
                          color: Color(0xFF181883),
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              if (estado == 'nao_cliente')
                Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          color: Color(0xFF181883),
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
