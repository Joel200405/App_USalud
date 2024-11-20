import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../styles/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Inicialización de la palabra "Cargando"
class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  String _loadingText = "Cargando";
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    _startLoading();
    _animateDots();
  }

  // Animación de la barra de carga
  void _startLoading() {
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _progress += 0.05;

        if (_progress >= 1.0) {
          timer.cancel();
          _navigateToLogin();
        }
      });
    });
  }

  // Animación de los puntos ...
  void _animateDots() {
    Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
        _loadingText = "Cargando" + "." * _dotCount;
      });
    });
  }

  // Función que navega al LoginScreen
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de la aplicación
            Image.asset(
              'assets/images/Logo_App.png',
              width: 250,
              height: 250,
            ),

            // Diseño de la barra de carga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Segundo diseño de la barra de carga
                  Positioned(
                    top: 2,
                    left: 2,
                    right: 2,
                    bottom: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  // Tercer diseño de la barra de carga (barra real)
                  Positioned(
                    top: 4,
                    left: 4,
                    right: 4,
                    bottom: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progress,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Texto "Cargando..."
            Text(
              _loadingText,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}