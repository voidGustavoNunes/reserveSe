import 'package:br_validators/validators/br_validators.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reservese/controle/cadastro/controle_tela_cadastro_restaurante.dart';

class CadastroRestaurantePage extends StatelessWidget {
  final ControleTelaCadastroRestaurante controller = ControleTelaCadastroRestaurante();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Restaurante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              _buildTextField(controller.nomeController, 'Nome', 'Por favor, insira o nome'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.telefoneController, 'Telefone', 'Por favor, insira um telefone'),
              const SizedBox(height: 16.0),
              _buildCNPJField(controller.cnpjController),
              const SizedBox(height: 16.0),
              _buildTextField(controller.logradouroController, 'Logradouro', 'Por favor, insira o logradouro'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.numeroController, 'Número', 'Por favor, insira o número'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.cepController, 'CEP', 'Por favor, insira o CEP'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.complementoController, 'Complemento'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.estadoController, 'Estado', 'Por favor, insira o estado'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.cidadeController, 'Cidade', 'Por favor, insira a cidade'),
              const SizedBox(height: 16.0),
              _buildTextField(controller.emailController, 'E-mail', 'Por favor, insira o e-mail'),
              const SizedBox(height: 16.0),
              _buildPasswordField(controller.senhaController, 'Senha', 'Por favor, insira a senha', controller),
              const SizedBox(height: 16.0),
              _buildPasswordField(controller.confirmaSenhaController, 'Confirme sua senha', 'As senhas não correspondem', controller),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  controller.cadastrar(context);
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, [String? validationMessage]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (validationMessage != null && (value == null || value.isEmpty)) {
          return validationMessage;
        }
        return null;
      },
    );
  }

  Widget _buildCNPJField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'CNPJ'),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CnpjInputFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira o CNPJ';
        }
        if (!BRValidators.validateCNPJ(value)) {
          return 'Por favor, insira um CNPJ válido';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, String mismatchMessage, ControleTelaCadastroRestaurante cadastroController) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira sua senha';
        }
        if (controller == cadastroController.confirmaSenhaController &&
            value != cadastroController.senhaController.text) {
          return mismatchMessage;
        }
        if (value.length < 6) {
          return 'A senha deve ter pelo menos 6 caracteres';
        }
        return null;
      },
    );
  }
}
