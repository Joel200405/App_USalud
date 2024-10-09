import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(AppSalud());
}

class AppSalud extends StatelessWidget {
  const AppSalud({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Salud',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Pantalla inicial
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/reset_password': (context) => ResetPasswordScreen(),
      },
    );
  }
}