import 'package:flutter/material.dart';

import '../../controle/principal/controle_tela_abertura.dart';

class TelaAbertura extends StatefulWidget {
  @override
  _TelaAberturaState createState() => _TelaAberturaState();
}

class _TelaAberturaState extends State<TelaAbertura> {
  ControleTelaAbertura _controle = ControleTelaAbertura();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controle.inicializarAplicacao(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.pinkAccent,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/reservese_logo.png", fit: BoxFit.contain),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 100),
            child: Text(
              "Reserve-se",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                // Sem linha abaixo do texto
                decoration: TextDecoration.none,
              ),

            ),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
