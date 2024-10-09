import 'package:flutter/material.dart';
import 'trapezoid_painter.dart';
import '../services/api_service.dart';
import '../styles/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberPassword = false;
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Inicio de sesión',
          style: TextStyle(
            color: AppColors.primary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.55,
                ),
                painter: TrapezoidPainter(),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: _buildLoginForm(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      width: 355,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.secondary,
            selectionColor: AppColors.secondary.withOpacity(0.3),
            selectionHandleColor: AppColors.secondary,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo_App.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            _buildEmailField(),
            _buildPasswordField(),
            _buildRememberMeCheckbox(),
            const SizedBox(height: 10),
            _buildLoginButton(),
            _buildForgotPasswordButton(context),
            _buildRegisterLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      cursorColor: AppColors.secondary,
    );
  }

  Widget _buildPasswordField() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          cursorColor: AppColors.secondary,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondary),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        Positioned(
          right: -12,
          child: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _rememberPassword,
          activeColor: AppColors.secondary,
          onChanged: (bool? value) {
            setState(() {
              _rememberPassword = value!;
            });
          },
        ),
        const Text(
          "Recordar contraseña",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        String correo = _emailController.text.trim();
        String contrasena = _passwordController.text.trim();
        
        // Lógica para iniciar sesión
        if (correo.isNotEmpty && contrasena.isNotEmpty) {
          var result = await _apiService.loginUser(correo: correo, contrasena: contrasena);
          if (result['error'] == true) {
            _showSnackbar(result['message']);
          } else {
            _showSnackbar("Inicio de sesión exitoso");
            // Navegación a otra pantalla después de inicio de sesión
            Navigator.pushReplacementNamed(context, '/home');
          }
        } else {
          _showSnackbar("Por favor, completa todos los campos.");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      child: const Text(
        '                INICIAR SESIÓN                ',
        style: TextStyle(
          color: AppColors.white,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/reset_password');
      },
      child: const Text(
        "¿Olvidaste tu contraseña?",
        style: TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "¿Aún no tienes cuenta? ",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            "Regístrate",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}