import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //TODO: conectar al socket server
      
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}
