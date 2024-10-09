import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Correo electrónico o celular'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar el código de verificación
              },
              child: const Text('ENVIAR'),
            ),
            TextButton(
              onPressed: () {
                // Lógica para volver a la pantalla de inicio de sesión
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("Volver a iniciar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
