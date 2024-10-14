import 'package:reservese/dominio/estado.dart';

import 'cidade.dart';

class UsuarioRestaurante{
  String? id = null;
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
    return 'Restaurante{id: $id, email: $email}';
  }

  UsuarioRestaurante.fromMap(Map<String, dynamic> map) {
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

  UsuarioRestaurante({this.id, this.nome, this.email, this.cnpj, this.cep, this.cidade,
                      this.complemento, this.estado, this.logradouro, this.numero});



}