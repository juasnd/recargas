import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pry_recargas_electronicas/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('shows the login form and validates empty fields', (tester) async {
    await tester.pumpWidget(const RecargasApp());

    expect(find.text('Bienvenido'), findsOneWidget);
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ingresa tu usuario.'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña.'), findsOneWidget);
  });

  testWidgets('demo credentials open the recharge dashboard', (tester) async {
    await tester.pumpWidget(const RecargasApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'fabian');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Fabián'), findsOneWidget);
    expect(find.text('Paquetes sugeridos'), findsOneWidget);
  });
}
