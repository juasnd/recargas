import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../atoms/app_button.dart';
import '../theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.usuario,
    required this.onRecharge,
    super.key,
  });

  final Usuario usuario;
  final VoidCallback onRecharge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 252,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 210,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 56),
            decoration: const BoxDecoration(
              color: AppTheme.blue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(34),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, ${usuario.name}',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        usuario.membership,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.82),
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.17),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 17, 16, 17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saldo actual',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.muted,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '\$0.00',
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: AppTheme.ink,
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    label: 'Recargar',
                    onPressed: onRecharge,
                    icon: Icons.add_rounded,
                    expand: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
