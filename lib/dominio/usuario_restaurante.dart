import 'dart:convert';

import 'package:reservese/dominio/estado.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/prefs.dart';
import 'cidade.dart';

class UsuarioRestaurante{
  late String id;
  String? email;
  String? cnpj;
  String? logradouro;
  int? numero;
  String? cep;
  String? complemento;
  String? cidade;
  String? estado;
  String? nome;
  String? telefone;

  @override
  String toString() {
    return 'Restaurante{id: $id, email: $email, nome: $nome, cnpj: $cnpj}';
  }

  UsuarioRestaurante.fromMap(Map<String, dynamic> map){
    nome = map["nome"];
    logradouro = map["logradouro"];
    telefone = map["telefone"];
    numero = map["numero"] is String ? int.tryParse(map["numero"]) : map["numero"];
    cep = map["cep"];
    cidade = map["cidade"];
    estado = map["estado"];
    email = map["email"];
    complemento = map['complemento'];
  }


  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['logradouro'] = this.logradouro;
    data['telefone'] = this.telefone;
    data['numero'] = this.numero;
    data['cep'] = this.cep;
    data['cidade'] = this.cidade;
    data['complemento'] = this.complemento;
    data['estado'] = this.estado;
    return data;
  }


  // Salvando o usuário em Shared Preferences
  void salvar(){
    // Transformando o usuário em map
    Map usuario_map = this.toMap();

    // Transformando a map em String
    String usuario_string = json.encode(usuario_map);

    // Armazenando o usuário em Shared Preferences
    Prefs.setString("usuario.prefs", usuario_string);
  }

  static Future<UsuarioRestaurante?> obter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tipoUsuario = prefs.getString("tipo_usuario");

    if (tipoUsuario == "restaurante") {
      String usuarioString = await Prefs.getString("usuarioRestaurante.prefs");
      if (usuarioString.isEmpty) return null;
      Map<String, dynamic> usuarioMap = json.decode(usuarioString);
      return UsuarioRestaurante.fromMap(usuarioMap);
    }
  }

  static Future<UsuarioRestaurante> obterNaoNulo() async{
    String usuario_string = await Prefs.getString("usuarioRestaurante.prefs");

    Map<String, dynamic> usuario_map = json.decode(usuario_string);

    UsuarioRestaurante usuario = UsuarioRestaurante.fromMap(usuario_map);
    return usuario;
  }

  static void limpar(){
    // Limpando o usuário em Shared Preferences
    Prefs.setString("usuarioRestaurante.prefs", "");
  }
}