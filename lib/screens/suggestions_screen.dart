import 'package:flutter/material.dart';
import '../styles/colors.dart'; // Asegúrate de tener esta ruta correcta

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final List<String> questions = [
    '¿Qué tan intuitiva es la aplicación?',
    '¿Qué tan útil encuentras la aplicación?',
    '¿La aplicación cumple con tus expectativas?',
    '¿Qué tan fácil fue navegar por la aplicación?',
    '¿Qué tan satisfecho estás con la apariencia de la aplicación?',
  ];

  final List<double> ratings = List.filled(5, 0); // Calificaciones iniciales en 0
  String comment = '';

  void _submitFeedback() {
    // Aquí puedes manejar la lógica para enviar comentarios y calificaciones
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.accent,
          contentPadding: const EdgeInsets.all(15.0),
          title: Text(
            'Gracias por tu comentario',
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
                child: const Text(
                  'Tu comentario nos ayudará a mejorar.',
                  style: TextStyle(
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'ACEPTAR',
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
            Navigator.of(context).pop(); // Vuelve a la pantalla anterior
          },
        ),
        title: const Text(
          'Sugerencias',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Ocultar el teclado al hacer tap en cualquier lugar
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
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
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Logo_App.png', // Asegúrate de que la ruta sea correcta
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(questions.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questions[index],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildStarRating(
                              index, ratings[index], (rating) {
                            setState(() {
                              ratings[index] = rating; // Actualiza la calificación
                            });
                          }),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                  const Text(
                    'Nos interesa tu comentario:',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        comment = value; // Captura el comentario del usuario
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), // Puedes ajustar el radio de los bordes
                        borderSide: BorderSide(
                          color: comment.isEmpty ? Colors.grey : AppColors.primary, // Cambia el color del borde aquí
                        ),
                      ),
                      hintText: 'Escribe aquí tus comentarios...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _submitFeedback(); // Enviar comentarios
                      },
                      style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        '   ENVIAR   ',
                          style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
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
    );
  }

  List<Widget> _buildStarRating(int questionIndex, double rating, Function(double) onRatingSelected) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        // Estrella llena
        stars.add(IconButton(
          icon: const Icon(
            Icons.star,
            color: Color.fromRGBO(250, 142, 4, 1),
          ),
          onPressed: () => onRatingSelected(i.toDouble()),
        ));
      } else if (i - rating < 1) {
        // Media estrella
        stars.add(IconButton(
          icon: const Icon(
            Icons.star_half,
            color: Color.fromRGBO(250, 142, 4, 1),
          ),
          onPressed: () => onRatingSelected(i.toDouble()),
        ));
      } else {
        // Estrella vacía
        stars.add(IconButton(
          icon: const Icon(
            Icons.star_border,
            color: Color.fromRGBO(250, 142, 4, 1),
          ),
          onPressed: () => onRatingSelected(i.toDouble()),
        ));
      }
    }
    return stars;
  }
}