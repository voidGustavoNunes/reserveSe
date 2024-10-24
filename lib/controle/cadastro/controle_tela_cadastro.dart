import 'package:br_validators/validators/br_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reservese/dominio/usuario.dart';
import 'package:reservese/pages/tela_principal_clientes.dart';

import '../util/nav.dart';

class ControleTelaCadastro {
  final _auth = FirebaseAuth.instance;
  CollectionReference<Map<String, dynamic>> get _collectionUsuarios =>
  FirebaseFirestore.instance.collection('usuarios');


  // Controladores de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataNascimentoController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  // Chave do formulário
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Função para validar o formulário e realizar o cadastro
  Future<void> cadastrar(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String senha = senhaController.text.trim();

      if (EmailValidator.validate(email)) {
        try {
          // Criando usuário no Firebase Auth
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: senha);

          // Salvando restaurante no Firestore
          _collectionUsuarios.add({
            'nome': nomeController.text,
            'data de nascimento': dataNascimentoController.text,
            'cpf': cpfController.text,
            'email': emailController.text,
            'senha': senhaController.text,
          }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso')),
          );
          push(context, TelaPrincipalClientes(userCredential.user as Usuario), replace: true);
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

  String? validarNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome';
    }
    return null;
  }

  String? validarCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu CPF';
    }
    bool isCpfValid = BRValidators.validateCPF(value);
    if (!isCpfValid) {
      return 'Por favor, insira um CPF válido';
    }
    return null;
  }

  String? validarDataNascimento(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua data de nascimento';
    }
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? validarConfirmacaoSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }
    if (value != senhaController.text) {
      return 'As senhas não correspondem';
    }
    return null;
  }

  void dispose() {
    nomeController.dispose();
    dataNascimentoController.dispose();
    cpfController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();
  }
}
