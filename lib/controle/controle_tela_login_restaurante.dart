import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';

import '../dominio/usuario.dart';
import '../dominio/usuario_restaurante.dart';
import '../pages/tela_principal_restaurantes.dart';
import '../util/nav.dart';
import '../util/toast.dart';

class ControleTelaLoginRestaurante {
  // Controles de edição do login e senha
  final TextEditingController controlador_login;
  final TextEditingController controlador_senha;

  // Controlador de formulário (para fazer validações)
  final GlobalKey<FormState> formkey;

  // Controladores de foco
  final FocusNode focus_senha = FocusNode();
  final FocusNode focus_botao = FocusNode();

  // Autenticação
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _collection_usuarios =>
      FirebaseFirestore.instance.collection('restaurantes');

  ControleTelaLoginRestaurante(this.formkey)
      : controlador_login = TextEditingController(),
        controlador_senha = TextEditingController();

  void logar(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      String login = controlador_login.text.trim();
      String senha = controlador_senha.text.trim();

      if (EmailValidator.validate(login)) {
        try {
          UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: login, password: senha);
          _verificarRestaurante(userCredential.user, context);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            MensagemAlerta(context, "Erro: Restaurante não encontrado para o email informado");
          } else if (e.code == 'wrong-password') {
            MensagemAlerta(context, "Erro: Password inválido!!!");
          }
        }
      } else {
        MensagemAlerta(context, "Erro: Email informado com formato inválido");
      }
    }
  }

  void _verificarRestaurante(User? user, BuildContext context) {
    _collection_usuarios.where("email", isEqualTo: user?.email).snapshots().listen((data) {
      if (data.docs.isNotEmpty) {
        final Map<String, dynamic> userData = data.docs[0].data();
        UsuarioRestaurante restaurante = UsuarioRestaurante.fromMap(userData);
        restaurante.id = data.docs[0].id;
        push(context, TelaPrincipalRestaurantes(restaurante), replace: true);
      }
    });
  }
}
