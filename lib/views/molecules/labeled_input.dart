import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../atoms/app_text_field.dart';
import '../theme/app_theme.dart';

class LabeledInput extends StatelessWidget {
  const LabeledInput({
    required this.label,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge
              ?.copyWith(color: AppTheme.ink, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        AppTextField(
          controller: controller,
          hintText: hintText,
          prefixIcon: prefixIcon,
          keyboardType: keyboardType,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          inputFormatters: inputFormatters,
          validator: validator,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
