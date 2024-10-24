import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservese/pages/tela_principal/cliente/tela_principal_clientes.dart';
import 'package:reservese/pages/tela_principal/restaurante/tela_principal_restaurantes.dart';
import '../../dominio/usuario.dart';
import '../../dominio/usuario_restaurante.dart';
import '../../pages/login/login_page.dart';
import 'package:flutter/material.dart';
import '../../util/nav.dart';

class ControleTelaAbertura {
  void inicializarAplicacao(BuildContext context) {
    // Dando um tempo para exibição da tela de abertura
    Future future = Future.delayed(Duration(seconds: 2));
    print('passou');

    future.then((value) {
      // Obtendo o Usuário (caso já esteja logado)
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          // Redireciona para a página de login se não estiver logado
          push(context, LoginPage(), replace: true);
        } else {
          // Primeiro, verifica se o usuário é um restaurante
          FirebaseFirestore.instance
              .collection('restaurantes') // Alterado para a coleção de restaurantes
              .where("email", isEqualTo: user.email)
              .get()
              .then((QuerySnapshot restaurantSnapshot) {
            if (restaurantSnapshot.docs.isNotEmpty) {
              // Usuário é um restaurante
              final Map<String, dynamic> restaurantData = restaurantSnapshot.docs[0].data() as Map<String, dynamic>;
              UsuarioRestaurante restaurante = UsuarioRestaurante.fromMap(restaurantData);
              restaurante.id = restaurantSnapshot.docs[0].id;
              push(context, TelaPrincipalRestaurantes(restaurante), replace: true);
            } else {
              // Verifica se o usuário é um cliente
              FirebaseFirestore.instance
                  .collection('usuarios') // Verifica na coleção de usuários
                  .where("email", isEqualTo: user.email)
                  .get()
                  .then((QuerySnapshot userSnapshot) {
                if (userSnapshot.docs.isNotEmpty) {
                  // Usuário é um cliente
                  final Map<String, dynamic> userData = userSnapshot.docs[0].data() as Map<String, dynamic>;
                  Usuario cliente = Usuario.fromMap(userData);
                  cliente.id = userSnapshot.docs[0].id;
                  push(context, TelaPrincipalClientes(cliente), replace: true);
                } else {
                  // Se não encontrar em nenhuma coleção, redireciona para login
                  push(context, LoginPage(), replace: true);
                }
              });
            }
          });
        }
      });
    });
  }
}
