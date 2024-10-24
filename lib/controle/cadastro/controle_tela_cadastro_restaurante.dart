import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:br_validators/br_validators.dart';
import 'package:reservese/dominio/usuario_restaurante.dart';

import '../pages/tela_principal_restaurantes.dart';
import '../util/nav.dart';

class ControleTelaCadastroRestaurante {
  final _auth = FirebaseAuth.instance;
  CollectionReference<Map<String, dynamic>> get _collectionRestaurantes =>
  FirebaseFirestore.instance.collection('restaurantes');



  final TextEditingController nomeController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  // Chave do formulário
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Função para cadastrar restaurante
  void cadastrar(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String senha = senhaController.text.trim();

      if (EmailValidator.validate(email)) {
        try {
          // Criando usuário no Firebase Auth
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: senha);

          // Salvando restaurante no Firestore
          _collectionRestaurantes.add({
            'nome': nomeController.text,
            'telefone': telefoneController.text,
            'cnpj': cnpjController.text,
            'logradouro': logradouroController.text,
            'numero': numeroController.text,
            'cep': cepController.text,
            'complemento': complementoController.text,
            'estado': estadoController.text,
            'cidade': cidadeController.text,
            'email': email,
          }).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cadastro realizado com sucesso')),
            );
            push(context, TelaPrincipalRestaurantes(userCredential.user as UsuarioRestaurante), replace: true);
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erro ao cadastrar: $error')),
            );
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            _mostrarErro(context, 'A senha fornecida é muito fraca');
          } else if (e.code == 'email-already-in-use') {
            _mostrarErro(context, 'Já existe uma conta com o email informado');
          }
        }
      } else {
        _mostrarErro(context, 'Email informado com formato inválido');
      }
    }
  }




  void _mostrarErro(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  // Função para liberar os recursos ao final
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    cnpjController.dispose();
    logradouroController.dispose();
    numeroController.dispose();
    cepController.dispose();
    complementoController.dispose();
    estadoController.dispose();
    cidadeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
  }
}
