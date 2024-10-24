import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservese/pages/cadastroRestaurante_page.dart';
import 'package:reservese/pages/login_page.dart';
import '../controle/controle_tela_login_restaurante.dart';

class LoginRestaurantePage extends StatelessWidget {
  LoginRestaurantePage({super.key});

  late final ControleTelaLoginRestaurante _controle = ControleTelaLoginRestaurante(formKey);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset(
            "assets/reservese_logo.png",
            width: 140,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Reserve-se",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Restaurantes",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
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
                CupertinoTextField(
                  controller: _controle.controlador_login,
                  padding: const EdgeInsets.all(10),
                  cursorColor: Colors.pinkAccent,
                  placeholder: "Digite o seu e-mail",
                  placeholderStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                CupertinoTextField(
                  controller: _controle.controlador_senha,
                  padding: const EdgeInsets.all(15),
                  cursorColor: Colors.pinkAccent,
                  placeholder: "Digite sua senha",
                  obscureText: true,
                  placeholderStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: const BoxDecoration(
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _controle.logar(context);
                      }
                    },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroRestaurantePage(),
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
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Sou um cliente",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
