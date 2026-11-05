import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppButtonStyle { primary, success }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.style = AppButtonStyle.primary,
    this.expand = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonStyle style;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        style == AppButtonStyle.success ? AppTheme.lime : AppTheme.blue;
    final foregroundColor = style == AppButtonStyle.success
        ? AppTheme.ink
        : Colors.white;
    final button = FilledButton.icon(
      onPressed: onPressed,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
      label: Text(label),
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 48),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: backgroundColor.withValues(alpha: 0.45),
        disabledForegroundColor: foregroundColor.withValues(alpha: 0.7),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
