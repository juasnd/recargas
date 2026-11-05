import 'package:flutter/material.dart';

import '../../controllers/recarga_controller.dart';
import '../../models/operadora.dart';
import '../../models/paquete.dart';
import '../../models/recarga.dart';
import '../../models/usuario.dart';
import '../atoms/phone_number_formatter.dart';
import '../atoms/section_title.dart';
import '../molecules/labeled_input.dart';
import '../molecules/operator_chip.dart';
import '../molecules/payment_chip.dart';
import '../organisms/home_header.dart';
import '../organisms/package_list.dart';
import '../theme/app_theme.dart';
import 'login_page.dart';
import 'receipt_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _recargaController = RecargaController();

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _recargaController.dispose();
    super.dispose();
  }

  void _addPackage(Paquete package) {
    final error = _recargaController.validatePhoneNumber(_phoneController.text);
    if (error != null) {
      _formKey.currentState!.validate();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          behavior: SnackBarBehavior.floating,
        ),
      );
      _phoneFocusNode.requestFocus();
      return;
    }

    final recarga = _recargaController.createRecarga(
      phoneNumber: _phoneController.text,
      paquete: package,
    );
    Navigator.pushNamed(
      context,
      ReceiptPage.routeName,
      arguments: recarga,
    );
  }

  void _showPhoneField() {
    _phoneFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: AnimatedBuilder(
          animation: _recargaController,
          builder: (context, _) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(bottom: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  usuario: Usuario.demo,
                  onRecharge: _showPhoneField,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SectionTitle(
                              title: 'Nueva recarga',
                              subtitle: 'Completa los datos del destinatario',
                            ),
                            IconButton(
                              tooltip: 'Cerrar sesión',
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginPage.routeName,
                                (route) => false,
                              ),
                              icon: const Icon(
                                Icons.logout_rounded,
                                color: AppTheme.muted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LabeledInput(
                          label: 'Número de teléfono',
                          controller: _phoneController,
                          hintText: '099 123 4567',
                          prefixIcon: Icons.phone_iphone_rounded,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          inputFormatters: const [PhoneNumberFormatter()],
                          validator: (value) => _recargaController
                              .validatePhoneNumber(value ?? ''),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          'Operadora',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppTheme.ink,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 9),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: Operadora.values
                              .map(
                                (operadora) => OperatorChip(
                                  operadora: operadora,
                                  selected: _recargaController
                                          .selectedOperadora ==
                                      operadora,
                                  onSelected: (selected) {
                                    if (selected) {
                                      _recargaController
                                          .selectOperadora(operadora);
                                    }
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Forma de pago',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppTheme.ink,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 9),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: FormaPago.values
                              .map(
                                (formaPago) => PaymentChip(
                                  formaPago: formaPago,
                                  selected: _recargaController
                                          .selectedFormaPago ==
                                      formaPago,
                                  onSelected: (selected) {
                                    if (selected) {
                                      _recargaController
                                          .selectFormaPago(formaPago);
                                    }
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 26),
                        PackageList(
                          packages: RecargaController.paquetes,
                          onAdd: _addPackage,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
