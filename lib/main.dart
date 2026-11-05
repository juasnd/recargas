import 'package:flutter/material.dart';

import 'views/pages/home_page.dart';
import 'views/pages/login_page.dart';
import 'views/pages/receipt_page.dart';
import 'views/theme/app_theme.dart';

void main() {
  runApp(const RecargasApp());
}

class RecargasApp extends StatelessWidget {
  const RecargasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recargas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (_) => const LoginPage(),
        HomePage.routeName: (_) => const HomePage(),
        ReceiptPage.routeName: (_) => const ReceiptPage(),
      },
    );
  }
}
