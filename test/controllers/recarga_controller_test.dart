import 'package:flutter_test/flutter_test.dart';
import 'package:pry_recargas_electronicas/controllers/recarga_controller.dart';
import 'package:pry_recargas_electronicas/models/operadora.dart';

void main() {
  group('RecargaController', () {
    late RecargaController controller;

    setUp(() {
      controller = RecargaController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('validates a ten-digit phone number', () {
      expect(controller.validatePhoneNumber('099 123 4567'), isNull);
      expect(
        controller.validatePhoneNumber('099123'),
        'El número debe tener 10 dígitos.',
      );
      expect(
        controller.validatePhoneNumber(''),
        'Ingresa el número de teléfono.',
      );
    });

    test('calculates commission, total, and store earnings', () {
      controller.selectOperadora(Operadora.claro);
      final recarga = controller.createRecarga(
        phoneNumber: '099 123 4567',
        paquete: RecargaController.paquetes.first,
      );

      expect(recarga.amount, 179);
      expect(recarga.commission, closeTo(7.16, 0.001));
      expect(recarga.total, closeTo(186.16, 0.001));
      expect(recarga.earnings, closeTo(3.58, 0.001));
      expect(recarga.phoneNumber, '0991234567');
    });

    test('uses the operator-specific commission rate', () {
      controller.selectOperadora(Operadora.cnt);
      final recarga = controller.createRecarga(
        phoneNumber: '0991234567',
        paquete: RecargaController.paquetes.first,
      );

      expect(recarga.commission, closeTo(8.95, 0.001));
      expect(recarga.total, closeTo(187.95, 0.001));
    });
  });
}
