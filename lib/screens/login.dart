import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_flutter_cortedos/provider/login_provider.dart';
import 'package:taller_flutter_cortedos/theme/app_theme.dart';
import 'package:taller_flutter_cortedos/utils/google_auth_simulation.dart';
import 'package:taller_flutter_cortedos/utils/validators.dart';
import 'package:taller_flutter_cortedos/widgets/app_logo.dart';
import 'package:taller_flutter_cortedos/widgets/app_text_field.dart';
import 'package:taller_flutter_cortedos/widgets/primary_button.dart';
import 'package:taller_flutter_cortedos/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: const LoginScreen._(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.spaceLg),
                  const Center(child: AppLogo(size: 100)),
                  const SizedBox(height: AppTheme.spaceMd),
                  Text('Iniciar sesión', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
                  const SizedBox(height: AppTheme.spaceXl),
                  AppTextField(
                    controller: provider.userOrEmail,
                    label: 'Usuario o correo',
                    prefixIcon: Icons.alternate_email,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: Validators.userOrEmail,
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  AppTextField(
                    controller: provider.password,
                    label: 'Contraseña',
                    prefixIcon: Icons.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: Validators.loginPassword,
                    showVisibilityToggle: true,
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pushNamed('/forgot'),
                      child: const Text('¿Olvidaste tu contraseña?'),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  PrimaryButton(
                    label: 'Iniciar sesión',
                    icon: Icons.login,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      provider.loginDebugPrint();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Inicio de sesión simulado (válido).')),
                      );
                      showDialog<void>(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Confirmación'),
                            content: Text('Bienvenido, ${provider.userOrEmail.text.trim()}'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cerrar')),
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home',
                                    (route) => false,
                                    arguments: {'source': 'login', 'user': provider.userOrEmail.text.trim()},
                                  );
                                },
                                child: const Text('Ir al inicio'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceMd),
                        child: Text('o', style: Theme.of(context).textTheme.bodySmall),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  SocialButton(
                    label: 'Continuar con Google',
                    onPressed: () => GoogleAuthSimulation.run(context, kind: GoogleSimulationKind.login),
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿No tienes cuenta?'),
                      TextButton(
                        onPressed: () => Navigator.of(context).pushNamed('/register'),
                        child: const Text('Crear cuenta'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
