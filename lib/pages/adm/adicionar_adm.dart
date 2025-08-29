// lib/pages/adm/adicionar_adm.dart
import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar_geral.dart';

class AdicionarAdmPage extends StatefulWidget {
  @override
  _AdicionarAdmPageState createState() => _AdicionarAdmPageState();
}

class _AdicionarAdmPageState extends State<AdicionarAdmPage> {
  String tipoDoc = "CPF";
  String grupoCadastro = "Residencial"; // mock inicial

  final TextEditingController docController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController(
    text: "1234",
  );
  bool senhaVisivel = false;

  // Mock lista de contas criadas
  List<Map<String, String>> contas = [
    {"doc": "123.456.789-00", "nome": "Maria Oliveira", "grupo": "Residencial"},
    {"doc": "98.765.432/0001-99", "nome": "Empresa XPTO", "grupo": "Comercial"},
  ];

  void _salvarConta() {
    if (docController.text.isEmpty || nomeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Preencha todos os campos"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      contas.add({
        "doc": docController.text,
        "nome": nomeController.text,
        "grupo": grupoCadastro,
      });
    });

    docController.clear();
    nomeController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Conta criada com sucesso!"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final azul = const Color(0xFF181883);
    final laranja = const Color(0xFFFF9900);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Adicionar Conta", style: TextStyle(color: azul)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: azul),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
        child: Column(
          children: [
            // CPF / CNPJ Dropdown
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                value: tipoDoc,
                underline: SizedBox(),
                items: const [
                  DropdownMenuItem(value: "CPF", child: Text("CPF")),
                  DropdownMenuItem(value: "CNPJ", child: Text("CNPJ")),
                ],
                onChanged: (value) {
                  if (value != null) {
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
            const SizedBox(height: 6),
            _buildInput(
              docController,
              hint: tipoDoc == "CPF" ? "000.000.000-00" : "00.000.000/0000-00",
              azul: azul,
              laranja: laranja,
            ),

            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nome",
                style: TextStyle(
                  color: laranja,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 6),
            _buildInput(
              nomeController,
              hint: "Digite o nome",
              azul: azul,
              laranja: laranja,
            ),

            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Grupo de Cadastro",
                style: TextStyle(
                  color: laranja,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFFFD700), width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButton<String>(
                value: grupoCadastro,
                isExpanded: true,
                underline: SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: "Residencial",
                    child: Text("Residencial"),
                  ),
                  DropdownMenuItem(
                    value: "Comercial",
                    child: Text("Comercial"),
                  ),
                  DropdownMenuItem(
                    value: "Industrial",
                    child: Text("Industrial"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => grupoCadastro = value);
                  }
                },
                style: TextStyle(color: azul, fontSize: 16),
                dropdownColor: Colors.white,
              ),
            ),

            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Senha (padrão 1234)",
                style: TextStyle(
                  color: laranja,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: senhaController,
              obscureText: !senhaVisivel,
              readOnly: true,
              style: TextStyle(color: azul, fontSize: 16),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    color: azul,
                  ),
                  onPressed: () {
                    setState(() {
                      senhaVisivel = !senhaVisivel;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _salvarConta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: azul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                child: const Text("Cadastrar Conta"),
              ),
            ),

            const SizedBox(height: 16),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Contas já cadastradas",
                style: TextStyle(
                  color: azul,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Lista de mocks
            ...contas.map(
              (c) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Color(0xFFFFD700), width: 2),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: azul),
                  title: Text(
                    c["nome"]!,
                    style: TextStyle(color: azul, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${c["doc"]}\nGrupo: ${c["grupo"]}",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /// ✅ Navbar ADM
      bottomNavigationBar: CustomBottomNavBarGeral(
        selectedIndex: 1, // está na aba "Adicionar"
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home_adm');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/adicionar');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/perfil_adm');
          }
        },
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller, {
    required String hint,
    required Color azul,
    required Color laranja,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: azul, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFFFD700), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFFFFD700), width: 2.2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
