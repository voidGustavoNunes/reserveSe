import 'package:flutter/material.dart';
import 'package:reservese/pages/login/login_page.dart';
import '../../../dominio/usuario.dart';
// import '../../tela_ajuda.dart';
// import '../../tela_edicao_usuario.dart';

import '../../../util/nav.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  Usuario? usuario;
  Future<Usuario>? future;

  @override
  void initState() {
    super.initState();
    // Inicializa o Future para obter o usuário
    future = Usuario.obterNaoNulo();
  }

  // Cabeçalho do menu com as informações do usuário
  UserAccountsDrawerHeader _header() {
    return UserAccountsDrawerHeader(
      accountName: Text(usuario?.nome ?? 'Usuário'),
      accountEmail: Text(usuario?.email ?? 'Login não disponível'),
      currentAccountPicture: CircleAvatar(
        child: Icon(Icons.person, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (context, snapshot) {
                usuario = snapshot.data;
                if (usuario == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _header();
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Editar Dados do Usuário"),
              subtitle: Text("nome, login, senha ..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Fechar o menu e navegar para a tela de edição
                pop(context);
                // push(context, TelaEdicaoUsuario(usuario!));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("como usar"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Fechar o menu e navegar para a tela de ajuda
                pop(context);
                // push(context, TelaAjuda());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Fechar o menu e redirecionar para a tela de login
                pop(context);
                push(context, LoginPage(), replace: true);

                // Limpar dados do usuário
                Usuario.limpar();
              },
            ),
          ],
        ),
      ),
    );
  }
}
