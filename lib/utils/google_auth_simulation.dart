import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../app_navigator.dart';

enum GoogleSimulationKind { login, register }

/// Flujo visual Google: diálogo **Cargando…** y luego **Acceso exitoso / Cancelado** (sin API real).
abstract final class GoogleAuthSimulation {
  static Future<void> run(
    BuildContext context, {
    required GoogleSimulationKind kind,
  }) async {
    if (!context.mounted) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return const AlertDialog(
          content: Row(
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text('Cargando…'),
              ),
            ],
          ),
        );
      },
    );

    await Future<void>.delayed(const Duration(milliseconds: 1500));

    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (!context.mounted) return;

    final success = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Google (simulación)'),
          content: const Text(
            'El taller es solo frontend: no hay login real con Google. '
            'Después de “Cargando…”, la actividad pide mostrar un resultado simulado. '
            'Elige si el acceso fue exitoso o se canceló, para ver la navegación o el mensaje.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelado'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Acceso exitoso'),
            ),
          ],
        );
      },
    );

    if (success == true) {
      if (kind == GoogleSimulationKind.login) {
        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      } else {
        appNavigatorKey.currentState?.pushNamedAndRemoveUntil('/', (route) => false);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          final ctx = appNavigatorKey.currentContext;
          if (ctx != null && ctx.mounted) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Registro con Google (simulado). Vuelve a iniciar sesión.')),
            );
          }
        });
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Acceso con Google cancelado.')),
        );
      }
    }
  }
}
