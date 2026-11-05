import 'operadora.dart';
import 'paquete.dart';

enum FormaPago {
  efectivo('Efectivo'),
  tarjeta('Tarjeta'),
  saldo('Saldo');

  const FormaPago(this.label);

  final String label;
}

class Recarga {
  const Recarga({
    required this.id,
    required this.phoneNumber,
    required this.operadora,
    required this.paquete,
    required this.formaPago,
    required this.amount,
    required this.commission,
    required this.total,
    required this.earnings,
    required this.createdAt,
  });

  final String id;
  final String phoneNumber;
  final Operadora operadora;
  final Paquete paquete;
  final FormaPago formaPago;
  final double amount;
  final double commission;
  final double total;
  final double earnings;
  final DateTime createdAt;
}
