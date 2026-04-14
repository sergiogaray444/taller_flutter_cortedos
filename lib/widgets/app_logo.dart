import 'package:flutter/material.dart';

/// Logo de la app. Si falta el archivo, muestra un ícono.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96});

  static const String _assetPath = 'assets/images/logo (2).png';

  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Image.asset(
      _assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.lock_outline, size: size * 0.65, color: color);
      },
    );
  }
}
