import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservese/pages/tela_principal/cliente/tela_principal_clientes.dart';
import 'package:reservese/pages/tela_principal/restaurante/tela_principal_restaurantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dominio/usuario.dart';
import '../../dominio/usuario_restaurante.dart';
import '../../pages/login/login_page.dart';
import 'package:flutter/material.dart';
import '../../util/nav.dart';

class ControleTelaAbertura {
  void inicializarAplicacao(BuildContext context) async {
    // Dando um tempo para exibição da tela de abertura
    await Future.delayed(Duration(seconds: 2));

    // Obtendo o Usuário (caso já esteja logado)
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("tipo_usuario"); // Limpa o tipo de usuário antes de verificar novamente
      String? tipoUsuario = prefs.getString("tipo_usuario");

      if (user == null || tipoUsuario == null) {
        // Redireciona para a página de login se não estiver logado
        if (context.mounted) {
          await prefs.remove("tipo_usuario");
          push(context, LoginPage(), replace: true);
        }
      } else {

        // Primeiro, verifica se o usuário é um restaurante
        FirebaseFirestore.instance
            .collection('restaurantes')
            .where("email", isEqualTo: user.email)
            .get()
            .then((QuerySnapshot restaurantSnapshot) async {
          if (restaurantSnapshot.docs.isNotEmpty) {
            // Usuário é um restaurante
            final Map<String, dynamic> restaurantData = restaurantSnapshot.docs[0].data() as Map<String, dynamic>;
            UsuarioRestaurante restaurante = UsuarioRestaurante.fromMap(restaurantData);
            restaurante.id = restaurantSnapshot.docs[0].id;

            // Salva o tipo do usuário no SharedPreferences
            await prefs.setString("tipo_usuario", "restaurante");

            if (context.mounted) {
              Future<UsuarioRestaurante?> futureRestaurante = UsuarioRestaurante.obter();
              Future.wait([futureRestaurante]).then((List values){
                UsuarioRestaurante? usuarioRestaurante = values[0];
                if(usuarioRestaurante != null){
                  push(
                      context,
                      TelaPrincipalRestaurantes(restaurante: restaurante),  // Passa o parâmetro
                      replace: true
                  );
                }
                else{
                  push(context, LoginPage(), replace: true);
                }
              });
            }
          } else {
            // Verifica se o usuário é um cliente
            FirebaseFirestore.instance
                .collection('usuarios')
                .where("email", isEqualTo: user.email)
                .get()
                .then((QuerySnapshot userSnapshot) async {
              if (userSnapshot.docs.isNotEmpty) {
                // Usuário é um cliente
                final Map<String, dynamic> userData = userSnapshot.docs[0].data() as Map<String, dynamic>;
                Usuario cliente = Usuario.fromMap(userData);
                cliente.id = userSnapshot.docs[0].id;

                // Salva o tipo do usuário no SharedPreferences
                await prefs.setString("tipo_usuario", "cliente");

                if (context.mounted) {
                  push(context, TelaPrincipalClientes(cliente), replace: true);
                }
              } else {
                // Se não encontrar em nenhuma coleção, redireciona para login
                if (context.mounted) {
                  push(context, LoginPage(), replace: true);
                }
              }
            });
          }
        });
      }
    });
  }
}