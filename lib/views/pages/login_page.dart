import 'package:flutter/material.dart';

import '../../controllers/login_controller.dart';
import '../atoms/app_button.dart';
import '../atoms/brand_mark.dart';
import '../molecules/labeled_input.dart';
import '../theme/app_theme.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = LoginController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    final success = _loginController.authenticate(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  void _clear() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: BrandMark()),
                    const SizedBox(height: 54),
                    Text(
                      'Bienvenido',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.ink,
                                fontWeight: FontWeight.w900,
                              ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Ingresa a tu cuenta para gestionar recargas.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.muted,
                          ),
                    ),
                    const SizedBox(height: 30),
                    LabeledInput(
                      label: 'Usuario',
                      controller: _usernameController,
                      hintText: 'Tu usuario',
                      prefixIcon: Icons.person_outline_rounded,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) => value == null || value.trim().isEmpty
                          ? 'Ingresa tu usuario.'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    LabeledInput(
                      label: 'Contraseña',
                      controller: _passwordController,
                      hintText: 'Tu contraseña',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword
                            ? 'Mostrar contraseña'
                            : 'Ocultar contraseña',
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Ingresa tu contraseña.'
                          : null,
                    ),
                    const SizedBox(height: 26),
                    AppButton(
                      label: 'Iniciar sesión',
                      onPressed: _login,
                      icon: Icons.arrow_forward_rounded,
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: TextButton(
                        onPressed: _clear,
                        child: const Text('Limpiar campos'),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Acceso de prueba: fabian · 1234',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.muted,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
