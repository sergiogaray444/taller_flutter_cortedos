import 'package:flutter/material.dart';
import 'package:taller_flutter_cortedos/app_navigator.dart';
import 'package:taller_flutter_cortedos/screens/forgot_password.dart';
import 'package:taller_flutter_cortedos/screens/home.dart';
import 'package:taller_flutter_cortedos/screens/login.dart';
import 'package:taller_flutter_cortedos/screens/register.dart';
import 'package:taller_flutter_cortedos/theme/app_theme.dart';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autenticación',
      debugShowCheckedModeBanner: false,
      navigatorKey: appNavigatorKey,
      theme: AppTheme.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen.init(context),
        '/register': (_) => const RegisterScreen(),
        '/forgot': (_) => const ForgotPasswordScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
