import 'package:flutter_test/flutter_test.dart';
import 'package:taller_flutter_cortedos/main.dart';

void main() {
  testWidgets('Muestra pantalla de inicio de sesión', (WidgetTester tester) async {
    await tester.pumpWidget(const AuthApp());
    await tester.pumpAndSettle();

    expect(find.text('Iniciar sesión'), findsWidgets); // título + botón
    expect(find.text('Usuario o correo'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);
  });
}
