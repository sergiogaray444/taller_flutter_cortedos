import 'package:flutter/material.dart';

/// Pantalla de inicio (placeholder) tras un acceso simulado.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    String detail = 'Sesión simulada';
    if (args is Map) {
      final user = args['user'] ?? args['email'];
      final source = args['source'];
      if (user != null) detail = 'Origen: $source — $user';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_outlined, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              const Text('Bienvenido', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(detail, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
