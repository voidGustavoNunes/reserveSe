import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservese/pages/cadastro_page.dart';
import 'package:reservese/pages/login_restaurante_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a setinha de voltar
        title: Center(
          child: Image.asset(
            "assets/reservese_logo.png",
            width: 140,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false, // Define para não redimensionar o corpo
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Remove o foco ao clicar fora do campo
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(27),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.pinkAccent,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100), // Espaçamento para a logo no AppBar
              const Text(
                "Reserve-se",
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                  fontSize: 24, // Tamanho do texto
                  fontWeight: FontWeight.bold, // Texto em negrito
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Digite os dados de acesso nos campos abaixo: ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const CupertinoTextField(
                padding: EdgeInsets.all(10),
                cursorColor: Colors.pinkAccent,
                placeholder: "Digite o seu e-mail",
                placeholderStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const CupertinoTextField(
                padding: EdgeInsets.all(15),
                cursorColor: Colors.pinkAccent,
                placeholder: "Digite sua senha",
                obscureText: true,
                placeholderStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    print("Esqueceu sua senha? Clicado");
                  },
                  child: const Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(15),
                  color: Colors.greenAccent,
                  child: const Text(
                    "Acessar",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 7),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 0.8),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: CupertinoButton(
                  child: const Text(
                    "Crie sua conta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    // Navega para a página de cadastro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroPage(), // Página de Cadastro
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginRestaurantePage(), // Página de Login de Restaurante
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Sou um restaurante",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Espaçamento para botão de criar conta
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.white70,
                      thickness: 0.8,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "ou entre com",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white70,
                      thickness: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 0.8),
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/google_logo.png",
                      width: 50,
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      "assets/facebook_logo.png",
                      width: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}