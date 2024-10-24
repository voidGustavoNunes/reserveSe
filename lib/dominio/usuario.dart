class Usuario {
  String? id = null;
  String? email;
  String? nome;
  String? cpf;
  String? dataNascimento;

  @override
  String toString() {
    return 'Usuario{id: $id, email: $email}';
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    email = map["email"];
    nome = map["nome"];
    cpf = map["cpf"];
    dataNascimento = map["dataNascimento"];
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['dataNascimento'] = this.dataNascimento;
    return data;
  }
}