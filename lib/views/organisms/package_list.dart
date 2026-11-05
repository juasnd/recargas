import 'package:flutter/material.dart';

import '../../models/paquete.dart';
import '../atoms/section_title.dart';
import '../molecules/package_card.dart';

class PackageList extends StatelessWidget {
  const PackageList({
    required this.packages,
    required this.onAdd,
    super.key,
  });

  final List<Paquete> packages;
  final ValueChanged<Paquete> onAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Paquetes sugeridos',
          subtitle: 'Elige una opción para continuar',
        ),
        const SizedBox(height: 14),
        ListView.builder(
          itemCount: packages.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final package = packages[index];
            return PackageCard(
              package: package,
              onAdd: () => onAdd(package),
            );
          },
        ),
      ],
    );
  }
}
