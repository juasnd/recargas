import 'package:flutter/material.dart';

import '../../models/operadora.dart';
import '../theme/app_theme.dart';

class OperatorChip extends StatelessWidget {
  const OperatorChip({
    required this.operadora,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final Operadora operadora;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(operadora.name),
      avatar: Icon(
        operadora.icon,
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
