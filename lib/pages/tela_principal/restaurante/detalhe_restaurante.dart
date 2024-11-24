import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../dominio/usuario_restaurante.dart';

class DetalhesRestaurantePage extends StatelessWidget {
  final UsuarioRestaurante restaurante;

  DetalhesRestaurantePage(this.restaurante);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurante.nome ?? 'Detalhes do Restaurante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${restaurante.nome ?? 'Não disponível'}'),
            Text('Telefone: ${restaurante.telefone ?? 'Não disponível'}'),
            Text('Email: ${restaurante.email ?? 'Não disponível'}'),
            Text('Endereço: ${restaurante.logradouro ?? ''}, ${restaurante.numero ?? ''}'),
            Text('Cidade: ${restaurante.cidade ?? ''}'),
            Text('Estado: ${restaurante.estado ?? ''}'),
            Text('CEP: ${restaurante.cep ?? ''}'),
          ],
        ),
      ),
    );
  }
}