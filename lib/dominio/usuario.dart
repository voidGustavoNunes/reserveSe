import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../util/prefs.dart';


class Usuario{
  late String id;
  String? email;
  String? nome;
  String? cpf;
  String? dataNascimento;

  @override
  String toString() {
    return 'Usuario{id: $id, email: $email, nome: $nome}';
  }

  // Usuario({required this.id, this.nome, this.cpf, this.dataNascimento, this.email});


  Usuario.fromMap(Map<String, dynamic> map){
    email = map["email"];
    nome = map["nome"];
    cpf = map["cpf"];
    dataNascimento = map["dataNascimento"];

  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['dataNascimento'] = this.dataNascimento;
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

  static Future<Usuario?> obter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tipoUsuario = prefs.getString("tipo_usuario");
    print("TIPO DE USUARIO =============== : $tipoUsuario");

    if (tipoUsuario == "cliente") {
      String usuarioString = await Prefs.getString("usuario.prefs");
      if (usuarioString.isEmpty) return null;
      Map<String, dynamic> usuarioMap = json.decode(usuarioString);
      return Usuario.fromMap(usuarioMap);
    }
  }

  static Future<Usuario> obterNaoNulo() async{
    String usuario_string = await Prefs.getString("usuario.prefs");

    Map<String, dynamic> usuario_map = json.decode(usuario_string);

    Usuario usuario = Usuario.fromMap(usuario_map);

    return usuario;
  }

  static void limpar(){
    // Limpando o usuário em Shared Preferences
    Prefs.setString("usuario.prefs", "");
  }
}