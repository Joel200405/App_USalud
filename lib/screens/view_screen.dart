import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha
import '../services/api_service.dart'; // Asegúrate de que el path sea el correcto
import '../services/cita.dart'; // Asegúrate de que el path sea el correcto
import '../styles/colors.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({Key? key}) : super(key: key);

  // Función para formatear la fecha en formato legible
  String formatFecha(String fecha) {
    final dateTime = DateTime.parse(fecha);
    return DateFormat('dd/MM/yyyy').format(dateTime); // Ejemplo: 09/11/2024
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary, // Cambia el color del icono de retroceder
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Vuelve a la pantalla anterior
          },
        ),
        title: Text(
          'Lista de Citas',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontSize: MediaQuery.of(context).size.width * 0.045, // Ajusta el tamaño de fuente en función del ancho de la pantalla
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primary,
            ),
            color: AppColors.primary, // Color de fondo del menú desplegable
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)), // Bordes redondeados
            ),
            onSelected: (String route) {
              Navigator.pushNamed(context, route);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '/login',
                child: Row(
                  children: [
                    Icon(Icons.login, color: AppColors.white), // Ícono de inicio de sesión
                    const SizedBox(width: 8), // Espacio entre ícono y texto
                    Text(
                      'Inicio de Sesión',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/register',
                child: Row(
                  children: [
                    Icon(Icons.person_add, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Registro',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/reset_password',
                child: Row(
                  children: [
                    Icon(Icons.lock_reset, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Recuperar Contraseña',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/symptoms',
                child: Row(
                  children: [
                    Icon(Icons.add_circle, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Agregar Síntomas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/clinics',
                child: Row(
                  children: [
                    Icon(Icons.local_hospital, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Listado de Clínicas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/meeting',
                child: Row(
                  children: [
                    Icon(Icons.edit_note, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Agendar cita',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/perfil',
                child: Row(
                  children: [
                    Icon(Icons.event, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Citas',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: '/emergencias',
                child: Row(
                  children: [
                    Icon(Icons.check, color: AppColors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Sugerencias',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1),
      ),
      body: FutureBuilder<List<Cita>>(
        future: ApiService()
            .fetchCitas(), // Llama al método fetchCitas() del servicio API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se obtienen los datos
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si la solicitud falla
            return Center(child: Text('Error al cargar las citas'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Muestra un mensaje si no hay citas disponibles
            return Center(child: Text('No hay citas disponibles'));
          } else {
            // Construye la lista de citas
            final citas = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos citas por fila
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: citas.length,
                itemBuilder: (context, index) {
                  final cita = citas[index];
                  return _buildCitaCard(context, cita);
                },
              ),
            );
          }
        },
      ),
    );
  }

  // Método para construir el contenedor de cada cita
Widget _buildCitaCard(BuildContext context, Cita cita) {
  return GestureDetector(
    onTap: () {
      // Muestra detalles adicionales al tocar una cita
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.accent,
            contentPadding: const EdgeInsets.all(15.0),
            title: Text(
              '${cita.servicio} en ${cita.clinica}',
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
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Medico: ',
                          style: TextStyle(fontWeight: FontWeight.bold), // Estilo negrita
                        ),
                        TextSpan(text: '${cita.medico}\n'),
                        const TextSpan(
                          text: 'Documento: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${cita.documento}\n'),
                        const TextSpan(
                          text: 'Motivo: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${cita.motivo}\n'),
                        const TextSpan(
                          text: 'Fecha: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${formatFecha(cita.fecha)}\n'),
                        const TextSpan(
                          text: 'Hora: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${cita.hora}'),
                      ],
                    ),
                    textAlign: TextAlign.left,
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
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${cita.servicio} - ${cita.clinica}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha: ${formatFecha(cita.fecha)}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Hora: ${cita.hora}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

}