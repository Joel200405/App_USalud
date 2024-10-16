import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'trapezoid_painter.dart';
import '../styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureTextConfirmPassword = true;

  // Controladores para los campos de texto
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoPaternoController = TextEditingController();
  TextEditingController _apellidoMaternoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final Color defaultUnderlineColor = const Color.fromRGBO(95, 92, 92, 1);
  final Color focusedUnderlineColor = const Color.fromRGBO(74, 135, 198, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1), // Color del encabezado
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Image.asset(
          'assets/images/Logo_App.png',
          width: 140,
          height: 60,
          fit: BoxFit.contain,
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
          FocusScope.of(context).unfocus(); // Ocultar el teclado al hacer tap en cualquier lugar
        },
        child: Stack(
          children: [
            // Dibuja el trapezoide en la parte superior
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.55),
              painter: TrapezoidPainter(),
            ),
            // Centrar el contenedor de forma dinámica y evitar que se vea afectado por el teclado
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 355,
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.border,
                        width: 2,
                      ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Registrarse',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField('Nombres', _nombreController),
                        _buildTextField('Apellido paterno', _apellidoPaternoController),
                        _buildTextField('Apellido materno', _apellidoMaternoController),
                        _buildTextField('Número de celular', _telefonoController),
                        _buildTextField('Correo electrónico', _correoController),
                        _buildPasswordField('Contraseña', _passwordController),
                        _buildConfirmPasswordField(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            String nombre = _nombreController.text;
                            String apellidoPaterno = _apellidoPaternoController.text;
                            String apellidoMaterno = _apellidoMaternoController.text;
                            String telefono = _telefonoController.text;
                            String correo = _correoController.text;
                            String contrasena = _passwordController.text;

                            // Validación de contraseñas
                            if (_passwordController.text != _confirmPasswordController.text) {
                              _showDialog('Notificación de Alerta', 'Las contraseñas no coinciden.');
                              return;
                            }

                            // Llamado al servicio API
                            bool success = await ApiService().registerUser(
                              nombre: nombre,
                              apellidoPaterno: apellidoPaterno,
                              apellidoMaterno: apellidoMaterno,
                              correo: correo,
                              contrasena: contrasena,
                              telefono: telefono,
                            );

                            if (success) {
                              _showDialog('Notificación de Éxito', 'Usuario registrado correctamente.');
                            } else {
                              _showDialog('Notificación de Alerta', 'No se pudo crear el usuario, puede que ya exista.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            '                 CREAR CUENTA                 ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "¿Ya tienes una cuenta?",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text(
                                "Inicia sesión aquí",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: AppColors.primary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Ventana de notificación
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.accent,
          contentPadding: const EdgeInsets.all(15.0),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (title == 'Notificación de Éxito') {
                    Navigator.pushNamed(context, '/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  '    ACEPTAR    ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.textPrimary, // Color del texto que se escribe
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.textSecondary, // Color de la etiqueta
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppColors
                  .textSecondary), // Color de la línea debajo del campo
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: focusedUnderlineColor), // Color de la línea enfocada
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.textPrimary, // Color del texto que se escribe
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.textSecondary, // Color de la etiqueta
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppColors
                  .textSecondary), // Color de la línea debajo del campo
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: focusedUnderlineColor), // Color de la línea enfocada
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextField(
      controller: _confirmPasswordController,
      obscureText: _obscureTextConfirmPassword,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        color: AppColors.textPrimary, // Color del texto que se escribe
      ),
      decoration: InputDecoration(
        labelText: 'Confirmar contraseña',
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.textSecondary, // Color de la etiqueta
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.textSecondary), // Color de la línea debajo del campo
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: focusedUnderlineColor), // Color de la línea enfocada
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureTextConfirmPassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.iconColor,
          ),
          onPressed: () {
            setState(() {
              _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
            });
          },
        ),
      ),
    );
  }
}