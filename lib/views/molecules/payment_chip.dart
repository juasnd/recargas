import 'package:flutter/material.dart';

import '../../models/recarga.dart';
import '../theme/app_theme.dart';

class PaymentChip extends StatelessWidget {
  const PaymentChip({
    required this.formaPago,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final FormaPago formaPago;
  final bool selected;
  final ValueChanged<bool> onSelected;

  IconData get _icon => switch (formaPago) {
        FormaPago.efectivo => Icons.payments_outlined,
        FormaPago.tarjeta => Icons.credit_card_rounded,
        FormaPago.saldo => Icons.account_balance_wallet_outlined,
      };

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(formaPago.label),
      avatar: Icon(
        _icon,
        size: 17,
        color: selected ? AppTheme.blue : AppTheme.muted,
      ),
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
      backgroundColor: Colors.white,
      selectedColor: AppTheme.blue.withValues(alpha: 0.1),
      side: BorderSide(
        color: selected ? AppTheme.blue : const Color(0xFFE2E8ED),
      ),
      labelStyle: TextStyle(
        color: selected ? AppTheme.blue : AppTheme.ink,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}
