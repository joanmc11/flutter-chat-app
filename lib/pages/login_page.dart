import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Logo(titulo: 'Messenger'),
                  _Form(),
                  Labels(
                      ruta: 'register',
                      question: '¿No tienes cuenta?',
                      text: 'Crea una ahora!'),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
        CustomInput(
          icon: Icons.mail_outline,
          placeholder: 'Correo',
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,
        ),
        CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Contraseña',
          keyboardType: TextInputType.visiblePassword,
          textController: passCtrl,
          isPassword: true,
        ),
        BotonAzul(
          text: 'ingrese',
          onPressed: authService.autenticando
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  final loginOk = await authService.login(
                      emailCtrl.text.trim(), passCtrl.text.trim());
                  if (loginOk) {
                    socketService.connect();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    //Mostrar alerta
                    // ignore: use_build_context_synchronously
                    await mostrarAlerta(
                        context, 'Login incorrecto', 'Creedenciales erroneas');
                  }
                },
        )
      ]),
    );
  }
}
