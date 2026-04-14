/// Validaciones de formularios según el taller.
abstract final class Validators {
  static String? requiredField(String? value, {String message = 'El campo es requerido'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  /// Correo: no vacío, @, dominio con punto y TLD de al menos 2 caracteres.
  static String? email(String? value) {
    final empty = requiredField(value);
    if (empty != null) return empty;
    final v = value!.trim();
    if (v.contains(' ')) return 'El correo no puede llevar espacios';
    if (!v.contains('@')) return 'El correo debe contener @';
    final parts = v.split('@');
    if (parts.length != 2) return 'Ingresa un correo válido';
    final user = parts[0];
    final domain = parts[1];
    if (user.isEmpty || domain.isEmpty || !domain.contains('.')) {
      return 'Ingresa un correo válido';
    }
    final domainLabels = domain.split('.');
    final tld = domainLabels.isNotEmpty ? domainLabels.last : '';
    if (tld.length < 2) return 'El dominio del correo no es válido';
    if (!RegExp(r'^[a-zA-Z0-9.-]+$').hasMatch(domain)) {
      return 'Ingresa un correo válido';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+$').hasMatch(user)) {
      return 'La parte antes del @ no es válida';
    }
    return null;
  }

  /// Login / registro: si lleva @ se valida como correo; si no, usuario (mín. 4, caracteres permitidos).
  static String? userOrEmail(String? value) {
    final req = requiredField(value, message: 'Ingresa usuario o correo');
    if (req != null) return req;
    final v = value!.trim();
    if (v.contains('@')) {
      return email(v);
    }
    if (v.length < 4) {
      return 'Usuario: mínimo 4 caracteres';
    }
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(v)) {
      return 'Usuario: solo letras, números, ., _ y -';
    }
    return null;
  }

  static String? loginPassword(String? value) {
    return _passwordRules(value, emptyMessage: 'Ingresa tu contraseña');
  }

  static String? registerPassword(String? value) {
    return _passwordRules(value, emptyMessage: 'La contraseña es requerida');
  }

  /// Mín. 6, máx. 64, al menos una letra y un número, sin espacios (login y registro).
  static String? _passwordRules(String? value, {required String emptyMessage}) {
    final req = requiredField(value, message: emptyMessage);
    if (req != null) return req;
    final v = value!.trim();
    if (v.contains(' ')) return 'La contraseña no debe contener espacios';
    if (v.length < 6) return 'Mínimo 6 caracteres';
    if (v.length > 64) return 'Máximo 64 caracteres';
    if (!RegExp(r'[A-Za-z]').hasMatch(v)) {
      return 'Debe incluir al menos una letra';
    }
    if (!RegExp(r'[0-9]').hasMatch(v)) {
      return 'Debe incluir al menos un número';
    }
    return null;
  }

  static String? confirmPassword(String? value, String other) {
    final req = requiredField(value, message: 'Confirma tu contraseña');
    if (req != null) return req;
    if (value!.trim() != other.trim()) return 'Las contraseñas no coinciden';
    return null;
  }

  /// Nombre opcional: si se escribe, sin números; solo letras (con tildes), espacios, guión o apóstrofo.
  static String? optionalName(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final v = value.trim();
    if (v.length < 2) return 'Mínimo 2 caracteres';
    if (RegExp(r'[0-9]').hasMatch(v)) return 'El nombre no puede contener números';
    if (!RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s'.-]+$").hasMatch(v)) {
      return 'Usa solo letras, espacios, guión o apóstrofo';
    }
    return null;
  }
}
