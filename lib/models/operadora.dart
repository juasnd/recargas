import 'package:flutter/material.dart';

class Operadora {
  const Operadora({
    required this.name,
    required this.commissionRate,
    required this.color,
    required this.icon,
  });

  final String name;
  final double commissionRate;
  final Color color;
  final IconData icon;

  static const movistar = Operadora(
    name: 'Movistar',
    commissionRate: 0.03,
    color: Color(0xFF019DF4),
    icon: Icons.signal_cellular_alt_rounded,
  );
  static const claro = Operadora(
    name: 'Claro',
    commissionRate: 0.04,
    color: Color(0xFFE53935),
    icon: Icons.wifi_rounded,
  );
  static const cnt = Operadora(
    name: 'CNT',
    commissionRate: 0.05,
    color: Color(0xFF73C900),
    icon: Icons.cell_tower_rounded,
  );

  static const values = [movistar, claro, cnt];
}
