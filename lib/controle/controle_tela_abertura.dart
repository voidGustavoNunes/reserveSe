import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservese/pages/tela_principal_clientes.dart';
import 'package:reservese/pages/tela_principal_restaurantes.dart';
import '../dominio/usuario.dart';
import '../dominio/usuario_restaurante.dart';
import '../pages/login_page.dart';
import 'package:flutter/material.dart';

import '../util/nav.dart';

class ControleTelaAbertura {
  void inicializarAplicacao(BuildContext context) {
    // Dando um tempo para exibição da tela de abertura
    Future future = Future.delayed(Duration(seconds: 2));

    future.then((value) => {
    // Obtendo o Usuário (caso já esteja logado)
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // Redireciona para a página de login se não estiver logado
        push(context, LoginPage(), replace: true);
      } else {
      // Verifica o tipo de usuário logado (cliente ou restaurante)
      FirebaseFirestore.instance
        .collection('usuarios')
        .where("email", isEqualTo: user.email)
        .snapshots()
        .listen((data) {
        if (data.docs.isNotEmpty) {
          final Map<String, dynamic> userData = data.docs[0].data();

          if (userData.containsKey("id_restaurante")) {
            // Usuário é um restaurante
            UsuarioRestaurante restaurante = UsuarioRestaurante.fromMap(userData);
            restaurante.id = data.docs[0].id;
            push(context, TelaPrincipalRestaurantes(restaurante), replace: true);
          }
          else {
            // Usuário é um cliente
            Usuario cliente = Usuario.fromMap(userData);
            cliente.id = data.docs[0].id;
            push(context, TelaPrincipalClientes(cliente), replace: true);
          }
        }
        });
      }
    })
    });
  }


}
