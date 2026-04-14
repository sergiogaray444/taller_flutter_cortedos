import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Botón “Continuar con Google”: logo multicolor + texto, estilo pastilla.
///
/// El logo se carga con [rootBundle] + [Image.memory] para que en **Flutter Web**
/// no falle el empaquetado del `Image.asset` en algunos entornos.
class SocialButton extends StatefulWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  static const List<String> _tryPaths = [
    'assets/images/google_logo.png',
    'assets/images/png-clipart-google-google.png',
  ];

  late final Future<Uint8List?> _iconFuture;

  @override
  void initState() {
    super.initState();
    _iconFuture = _loadFirstAvailable();
  }

  static Future<Uint8List?> _loadFirstAvailable() async {
    for (final path in _tryPaths) {
      try {
        final data = await rootBundle.load(path);
        return data.buffer.asUint8List();
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  static const Color _borderGray = Color(0xFFDADCE0);
  static const Color _textGray = Color(0xFF3C4043);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: const BorderSide(color: _borderGray, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(100),
          splashColor: Colors.black12,
          highlightColor: Colors.black.withValues(alpha: 0.05),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 26,
                  height: 26,
                  child: FutureBuilder<Uint8List?>(
                    future: _iconFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      final bytes = snapshot.data;
                      if (bytes == null || bytes.isEmpty) {
                        return Icon(Icons.image_not_supported_outlined, size: 22, color: Colors.grey.shade700);
                      }
                      return Image.memory(
                        bytes,
                        width: 26,
                        height: 26,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.medium,
                        gaplessPlayback: true,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _textGray,
                    letterSpacing: 0.15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
