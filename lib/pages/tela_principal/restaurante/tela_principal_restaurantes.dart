import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservese/dominio/usuario_restaurante.dart';


class TelaPrincipalRestaurantes extends StatefulWidget {
  final UsuarioRestaurante restaurante;

  TelaPrincipalRestaurantes(this.restaurante);

  @override
  _TelaPrincipalRestaurantesState createState() => _TelaPrincipalRestaurantesState();

}
class _TelaPrincipalRestaurantesState extends State<TelaPrincipalRestaurantes> {
  @override
  Widget build(BuildContext context) {
    // Verifique se todos os métodos e widgets usados estão implementados
    return Scaffold(
      appBar: AppBar(title: Text('Tela Principal Restaurantes')),
      body: Center(
        child: Text('Bem-vindo, ${widget.restaurante.nome}'), // Exemplo
      ),
    );
  }
  

}