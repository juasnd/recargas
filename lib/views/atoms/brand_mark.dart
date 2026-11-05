import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: const BoxDecoration(
            color: AppTheme.blue,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.bolt_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'recargas',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.ink,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
        ),
      ],
    );
  }
}
