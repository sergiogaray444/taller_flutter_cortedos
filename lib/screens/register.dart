import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:taller_flutter_cortedos/app_navigator.dart';
import 'package:taller_flutter_cortedos/theme/app_theme.dart';
import 'package:taller_flutter_cortedos/utils/google_auth_simulation.dart';
import 'package:taller_flutter_cortedos/utils/validators.dart';
import 'package:taller_flutter_cortedos/widgets/app_logo.dart';
import 'package:taller_flutter_cortedos/widgets/app_text_field.dart';
import 'package:taller_flutter_cortedos/widgets/primary_button.dart';
import 'package:taller_flutter_cortedos/widgets/social_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _showRegisterConfirmation() async {
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Registro completado'),
          content: const Text('Cuenta creada (simulación). Serás enviado al inicio de sesión.'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final ctx = appNavigatorKey.currentContext;
      if (ctx != null && ctx.mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Registro guardado (simulado). Inicia sesión.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spaceLg, vertical: AppTheme.spaceMd),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: AppLogo(size: 72)),
                  const SizedBox(height: AppTheme.spaceMd),
                  AppTextField(
                    controller: _nameController,
                    label: 'Nombre (opcional)',
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                    validator: Validators.optionalName,
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  AppTextField(
                    controller: _emailController,
                    label: 'Correo electrónico',
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Contraseña',
                    prefixIcon: Icons.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: Validators.registerPassword,
                    showVisibilityToggle: true,
                  ),
                  const SizedBox(height: AppTheme.spaceMd),
                  AppTextField(
                    controller: _confirmController,
                    label: 'Confirmar contraseña',
                    prefixIcon: Icons.lock_reset_outlined,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) => Validators.confirmPassword(value, _passwordController.text),
                    showVisibilityToggle: true,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  PrimaryButton(
                    label: 'Registrarse',
                    icon: Icons.person_add_alt_1_outlined,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      debugPrint('Registro simulado: ${_emailController.text.trim()}');
                      await _showRegisterConfirmation();
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
                    label: 'Registrarse con Google',
                    onPressed: () => GoogleAuthSimulation.run(context, kind: GoogleSimulationKind.register),
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Volver al inicio de sesión'),
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
