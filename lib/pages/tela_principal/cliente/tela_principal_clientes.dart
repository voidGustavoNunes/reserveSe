import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reservese/dominio/usuario_restaurante.dart';

import '../../../dominio/usuario.dart';
import '../restaurante/detalhe_restaurante.dart';

class TelaPrincipalClientes extends StatefulWidget {
  final Usuario cliente;

  TelaPrincipalClientes(this.cliente);

  @override
  _TelaPrincipalClientesState createState() => _TelaPrincipalClientesState();
}

class _TelaPrincipalClientesState extends State<TelaPrincipalClientes> {
  final CollectionReference<Map<String, dynamic>> _collectionRestaurantes =
  FirebaseFirestore.instance.collection('restaurantes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text('Restaurantes'))
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _collectionRestaurantes.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar restaurantes'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum restaurante encontrado'));
          } else {
            final List<UsuarioRestaurante> restaurantes = snapshot.data!.docs
                .map((doc) => UsuarioRestaurante.fromMap(doc.data()))
                .toList();

            return ListView.builder(
              itemCount: restaurantes.length,
              itemBuilder: (context, index) {
                final restaurante = restaurantes[index];
                return ListTile(
                  title: Text(restaurante.nome ?? 'Sem nome'),
                  subtitle: Text('Telefone: ${restaurante.telefone ?? 'Sem telefone'}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesRestaurantePage(restaurante),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
