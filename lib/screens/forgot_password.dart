import 'package:flutter/material.dart';
import 'package:taller_flutter_cortedos/theme/app_theme.dart';
import 'package:taller_flutter_cortedos/utils/validators.dart';
import 'package:taller_flutter_cortedos/widgets/app_logo.dart';
import 'package:taller_flutter_cortedos/widgets/app_text_field.dart';
import 'package:taller_flutter_cortedos/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olvidé mi contraseña'),
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
                  const Center(child: AppLogo(size: 64)),
                  const SizedBox(height: AppTheme.spaceMd),
                  Text(
                    'Escribe el correo con el que te registraste. Enviaremos un enlace de recuperación (simulado).',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  AppTextField(
                    controller: _emailController,
                    label: 'Correo electrónico',
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: AppTheme.spaceLg),
                  PrimaryButton(
                    label: 'Enviar enlace',
                    icon: Icons.mark_email_read_outlined,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      final id = _emailController.text.trim();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Enlace enviado (simulado) a: $id')),
                      );
                      showDialog<void>(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Listo'),
                            content: Text(
                              'Revisa tu bandeja (simulación). Si existiera un servidor, '
                              'llegarían instrucciones para restablecer la contraseña.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('Cerrar'),
                              ),
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Volver al login'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: AppTheme.spaceSm),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Volver manualmente'),
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
