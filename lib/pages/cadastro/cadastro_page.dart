import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

import '../../controle/cadastro/controle_tela_cadastro.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final ControleTelaCadastro _controle = ControleTelaCadastro(); // Instancia o controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controle.formKey, // Usa o formKey do controlador
          child: Column(
            children: [
              TextFormField(
                controller: _controle.nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: _controle.validarNome, // Validação vinda do controlador
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controle.cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: _controle.validarCPF,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controle.dataNascimentoController,
                decoration: const InputDecoration(labelText: 'Data de Nascimento'),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: _controle.validarDataNascimento,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controle.emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: _controle.validarEmail,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controle.senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: _controle.validarSenha,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controle.confirmaSenhaController,
                decoration: const InputDecoration(labelText: 'Confirme sua senha'),
                obscureText: true,
                validator: _controle.validarConfirmacaoSenha,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  _controle.cadastrar(context); // Ação de cadastro
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controle.dispose(); // Libera os recursos no dispose
    super.dispose();
  }
}
