import 'package:flutter/foundation.dart';

import '../models/operadora.dart';
import '../models/paquete.dart';
import '../models/recarga.dart';

class RecargaController extends ChangeNotifier {
  Operadora selectedOperadora = Operadora.movistar;
  FormaPago selectedFormaPago = FormaPago.efectivo;

  static const paquetes = [
    Paquete(
      id: 'eventual-cc-duo',
      title: 'Paquete Eventual CC DUO',
      description: 'Redes sociales, llamadas y mensajes',
      price: 179,
      data: '4 GB',
      validity: '30 días',
    ),
    Paquete(
      id: 'conecta-10',
      title: 'Conecta 10',
      description: 'Datos para navegar y compartir',
      price: 100,
      data: '2 GB',
      validity: '15 días',
    ),
    Paquete(
      id: 'full-50',
      title: 'Full 50',
      description: 'Internet y minutos incluidos',
      price: 50,
      data: '1 GB',
      validity: '7 días',
    ),
  ];

  void selectOperadora(Operadora operadora) {
    selectedOperadora = operadora;
    notifyListeners();
  }

  void selectFormaPago(FormaPago formaPago) {
    selectedFormaPago = formaPago;
    notifyListeners();
  }

  String? validatePhoneNumber(String phoneNumber) {
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return 'Ingresa el número de teléfono.';
    }
    if (digits.length != 10) {
      return 'El número debe tener 10 dígitos.';
    }
    return null;
  }

  Recarga createRecarga({
    required String phoneNumber,
    required Paquete paquete,
  }) {
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final commission = paquete.price * selectedOperadora.commissionRate;
    final earnings = paquete.price * 0.02;
    return Recarga(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      phoneNumber: digits,
      operadora: selectedOperadora,
      paquete: paquete,
      formaPago: selectedFormaPago,
      amount: paquete.price,
      commission: commission,
      total: paquete.price + commission,
      earnings: earnings,
      createdAt: DateTime.now(),
    );
  }
}
