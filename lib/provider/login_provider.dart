import 'package:flutter/material.dart';

/// Estado del formulario de login (`provider`).
class LoginProvider with ChangeNotifier {
  final TextEditingController userOrEmail = TextEditingController();
  final TextEditingController password = TextEditingController();

  void loginDebugPrint() {
    debugPrint('Login simulado — usuario/correo: ${userOrEmail.text.trim()}');
  }

  @override
  void dispose() {
    userOrEmail.dispose();
    password.dispose();
    super.dispose();
  }
}
