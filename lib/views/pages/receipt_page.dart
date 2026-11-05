import 'package:flutter/material.dart';

import '../../models/recarga.dart';
import '../theme/app_theme.dart';
import 'home_page.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  static const routeName = '/receipt';

  @override
  Widget build(BuildContext context) {
    final recarga = ModalRoute.of(context)?.settings.arguments;
    if (recarga is! Recarga) {
      return Scaffold(
        appBar: AppBar(title: const Text('Comprobante')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.receipt_long_outlined, size: 48),
                const SizedBox(height: 12),
                const Text('No se encontró la información de la recarga.'),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomePage.routeName,
                    (route) => route.isFirst,
                  ),
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprobante'),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Volver',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: AppTheme.lime.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF548F00),
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    '¡Recarga realizada!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.ink,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'El comprobante de la operación está listo.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppTheme.muted),
                  ),
                  const SizedBox(height: 24),
                  _ReceiptCard(recarga: recarga),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 50),
                        backgroundColor: AppTheme.blue,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Nueva recarga'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReceiptCard extends StatelessWidget {
  const _ReceiptCard({required this.recarga});

  final Recarga recarga;

  @override
  Widget build(BuildContext context) {
    final date = recarga.createdAt;
    final dateText =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} · '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL PAGADO',
                            style:
                                Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppTheme.muted,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '\$${recarga.total.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: AppTheme.ink,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      recarga.operadora.icon,
                      color: recarga.operadora.color,
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Divider(height: 1),
                const SizedBox(height: 16),
                _ReceiptRow(
                  label: 'Número',
                  value: _formatPhone(recarga.phoneNumber),
                ),
                _ReceiptRow(
                  label: 'Operadora',
                  value: recarga.operadora.name,
                ),
                _ReceiptRow(
                  label: 'Paquete',
                  value: recarga.paquete.title,
                ),
                _ReceiptRow(
                  label: 'Forma de pago',
                  value: recarga.formaPago.label,
                ),
                const SizedBox(height: 7),
                const Divider(height: 1),
                const SizedBox(height: 11),
                _ReceiptRow(
                  label: 'Valor de recarga',
                  value: '\$${recarga.amount.toStringAsFixed(2)}',
                ),
                _ReceiptRow(
                  label:
                      'Comisión (${(recarga.operadora.commissionRate * 100).toStringAsFixed(0)}%)',
                  value: '\$${recarga.commission.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.confirmation_number_outlined,
                        color: AppTheme.blue,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Operación ${recarga.id}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.muted,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dateText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppTheme.muted),
                  ),
                ),
              ],
            ),
          ),
          const _TicketDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
            child: Row(
              children: [
                const Icon(
                  Icons.insights_rounded,
                  size: 16,
                  color: AppTheme.muted,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Ganancia del establecimiento',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppTheme.muted),
                  ),
                ),
                Text(
                  '\$${recarga.earnings.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.ink,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPhone(String phone) {
    if (phone.length != 10) return phone;
    return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6)}';
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppTheme.muted),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.ink,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketDivider extends StatelessWidget {
  const _TicketDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = (constraints.maxWidth / 14).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              count,
              (_) => Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
