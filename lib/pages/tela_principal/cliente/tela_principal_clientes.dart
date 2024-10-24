import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservese/dominio/usuario_restaurante.dart';

import '../../../dominio/usuario.dart';


class TelaPrincipalClientes extends StatefulWidget {
  final Usuario cliente;

  TelaPrincipalClientes(this.cliente);

  @override
  _TelaPrincipalClientesState createState() => _TelaPrincipalClientesState();

}
class _TelaPrincipalClientesState extends State<TelaPrincipalClientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Principal Clientes')),
      body: Center(
        child: Text('Bem-vindo, ${widget.cliente.nome}'), // Exemplo
      ),
    );
  }


}