import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../services/category.dart';
import '../services/api_service.dart'; // Asegúrate de importar ApiService
import 'package:dropdown_button2/dropdown_button2.dart';

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({super.key});

  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // Lista de categorías
  List<Category> _categories = [];
  Category? _selectedCategory;

  // Lista de síntomas seleccionados
  List<String> _selectedSymptoms = [];

  // Lista de síntomas sugeridos
  List<String> _suggestedSymptoms = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Carga las categorías al inicio
  }

  Future<void> _fetchCategories() async {
    ApiService apiService = ApiService();
    List<Category> categories = await apiService
        .fetchCategories(); // Asegúrate de que esta función devuelva una lista de objetos Category
    setState(() {
      _categories = categories;
    });
  }

  // Método para buscar síntomas en tiempo real
  void _onSearchSymptoms(String query) async {
    if (query.isNotEmpty) {
      try {
        _suggestedSymptoms = await ApiService().buscarSintomas(query);
      } catch (e) {
        print('Error al buscar síntomas: $e'); // Manejo básico del error
        _suggestedSymptoms =
            []; // Opcional: puedes mostrar un mensaje al usuario si es necesario
      }
      setState(() {});
    } else {
      _suggestedSymptoms = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 244, 220, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Diagnóstico de Síntomas',
          style: TextStyle(
            color: AppColors.primary,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
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
      ),
      body: Theme(
        data: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.secondary, // Cambia a tu color deseado
            selectionColor:
                Color.fromRGBO(74, 135, 198, 0.5), // Color de selección
            selectionHandleColor:
                AppColors.secondary, // Color del control de selección
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: CustomPaint(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildSymptomForm(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.secondary,
          decoration: const InputDecoration(
            hintText: 'Busca aquí tu síntoma',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
          onChanged: _onSearchSymptoms,
        ),
        const SizedBox(height: 10),
        _suggestedSymptoms.isNotEmpty
            ? Wrap(
                spacing: 10.0,
                runSpacing: 5.0,
                children: _suggestedSymptoms.map((symptom) {
                  return FilterChip(
                    label: Text(
                      symptom,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                    ),
                    selected: _selectedSymptoms.contains(symptom),
                    selectedColor: const Color.fromRGBO(110, 244, 220, 1),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedSymptoms.add(symptom);
                        } else {
                          _selectedSymptoms.remove(symptom);
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  );
                }).toList(),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildSymptomForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Logo_App.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          _buildSearchBar(), // Aquí añadimos el buscador
          const SizedBox(height: 20),
          _buildCategorySelector(),
          const SizedBox(height: 20),
          _buildSymptomSelector(),
          const SizedBox(height: 20),
          _buildAgeInput(),
          const SizedBox(height: 20),
          _buildDaysWithSymptomsInput(),
          const SizedBox(height: 20),
          _buildSelectedSymptoms(),
          const SizedBox(height: 30),
          _buildRecommendationButton(),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seleccione una categoría de síntomas:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 356,
          child: Row(
            children: [
              const Icon(
                Icons.grid_view, // Aquí puedes cambiar el ícono
                color: Colors.grey,
              ),
              const SizedBox(
                  width: 10), // Espacio entre el ícono y el DropdownButton2
              Expanded(
                child: DropdownButton2<Category>(
                  value: _selectedCategory,
                  hint: const Text(
                    'Seleccione una categoría',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  items: _categories.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (Category? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  isExpanded: true,
                  buttonStyleData: ButtonStyleData(
                    height: 60,
                    width: 367,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomSelector() {
    if (_selectedCategory == null)
      return const SizedBox(); // No mostrar nada si no hay categoría seleccionada

    // Aquí se utiliza una variable para almacenar síntomas
    List<String> _currentSymptoms = [];

    return FutureBuilder<List<String>>(
      future: ApiService().fetchSymptomByCategory(_selectedCategory!.id),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error al obtener síntomas: ${snapshot.error}');
        } else if (snapshot.hasData) {
          _currentSymptoms = snapshot.data!;

          // Ordena los síntomas de menor a mayor longitud
          _currentSymptoms.sort((a, b) => a.length.compareTo(b.length));
        } else {
          return const Text('No se encontraron síntomas.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecciona tus síntomas:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10.0, // Espaciado horizontal entre chips
              runSpacing: 5.0, // Espaciado vertical entre filas
              children: _currentSymptoms.map((symptom) {
                return FilterChip(
                  label: Text(
                    symptom,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  selected: _selectedSymptoms.contains(symptom),
                  selectedColor: const Color.fromRGBO(110, 244, 220, 1),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedSymptoms.add(symptom);
                      } else {
                        _selectedSymptoms.remove(symptom);
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Ajusta el valor para el redondeo
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAgeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrese su edad en años:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _ageController,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.secondary,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Su edad aquí',
            hintStyle: TextStyle(
              color: Colors.grey, // Color del hint
              fontWeight: FontWeight.bold, // Peso de la fuente del hint
              fontFamily: 'Poppins', // Familia de la fuente del hint
              fontSize: 16, // Tamaño de la fuente del hint
            ),
            prefixIcon:
                Icon(Icons.access_time, color: Colors.grey), // Ícono de la lupa
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: Colors.grey), // Color del borde cuando está inactivo
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: AppColors
                      .secondary), // Color del borde cuando está enfocado
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDaysWithSymptomsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrese la cantidad de días con síntomas:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _daysController,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.secondary,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'La cantidad de días aquí',
            hintStyle: TextStyle(
              color: Colors.grey, // Color del hint
              fontWeight: FontWeight.bold, // Peso de la fuente del hint
              fontFamily: 'Poppins', // Familia de la fuente del hint
              fontSize: 16, // Tamaño de la fuente del hint
            ),
            prefixIcon: Icon(Icons.hourglass_empty,
                color: Colors.grey), // Ícono de la lupa
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: Colors.grey), // Color del borde cuando está inactivo
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: AppColors
                      .secondary), // Color del borde cuando está enfocado
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedSymptoms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Síntomas seleccionados:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: _selectedSymptoms.map((symptom) {
            return Chip(
              label: Text(
                symptom,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              onDeleted: () {
                setState(() {
                  _selectedSymptoms.remove(symptom);
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20.0), // Ajusta el valor para el redondeo
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecommendationButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _submitForm,
        child: const Text(
          'DIAGNOSTICAR',
          style: TextStyle(
            color: Colors.white, // Cambia el color del texto a azul
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    // Validar si todos los campos están vacíos
    if (_ageController.text.isEmpty &&
        _daysController.text.isEmpty &&
        _selectedSymptoms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos.')),
      );
      return;
    }

    // Validar si los campos de edad y días de síntomas están vacíos
    if (_ageController.text.isEmpty && _daysController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete el campo de su edad y la cantidad de días con síntomas.')),
      );
      return;
    } else if (_ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete el campo de su edad.')),
      );
      return;
    } else if (_daysController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete el campo de la cantidad de días con sintomas.')),
      );
      return;
    }

    // Convertir los textos a enteros después de la validación de vacíos
    int edad = int.parse(_ageController.text);
    int diasSintomas = int.parse(_daysController.text);

    // Validar si la edad está en un rango válido (por ejemplo, entre 0 y 120 años)
    if (edad < 0 || edad > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor, ingresa una edad válida (entre 0 y 100 años)')),
      );
      return;
    }

    // Si los síntomas fueron seleccionados desde el buscador, no se necesita categoría
    bool seleccionDirecta =
        _selectedSymptoms.isNotEmpty && _selectedCategory == null;

    // Verifica si los síntomas están seleccionados y la categoría está presente si no se seleccionó directamente
    if (_selectedSymptoms.isEmpty ||
        (!seleccionDirecta && _selectedCategory == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, selecciona una categoría y síntomas')),
      );
      return;
    }

    Map<String, int> sintomasIds = {
      "Congestión nasal": 1,
      "Tos seca": 2,
      "Tos con flema": 3,
      "Dolor de garganta": 4,
      "Estornudos": 5,
      "Falta de aire": 6,
      "Respiración rápida": 7,
      "Silbidos al respirar": 8,
      "Dolor en el pecho": 9,
      "Tos con sangre": 10,
      "Fiebre": 11,
      "Escalofríos": 12,
      "Sudores nocturnos": 13,
      "Fatiga extrema": 14,
      "Pérdida de peso": 15,
      "Malestar general": 16,
      "Dolor muscular": 17,
      "Dolor en las articulaciones": 18,
      "Dolor de cabeza": 19,
      "Náuseas": 20,
      "Vómitos": 21,
      "Diarrea": 22,
      "Dolor abdominal": 23,
      "Pérdida de apetito": 24,
      "Hambre excesiva": 25,
      "Dolor al tragar": 26,
      "Visión borrosa": 27,
      "Mareos": 28,
      "Cambios en la visión": 29,
      "Confusión": 30,
      "Ansiedad": 31,
      "Hormigueo en manos o pies": 32,
      "Sarpullido": 33,
      "Heridas lentas": 34,
      "Moretones": 35,
      "Piel seca": 36,
      "Costras en la piel": 37,
      "Sangrado en encías": 38,
      "Dolor en la lengua": 39,
      "Llagas en la boca": 40,
      "Uñas quebradizas": 41,
      "Orina frecuente": 42,
      "Sangre en la orina": 43,
      "Dolor al orinar": 44,
      "Infecciones urinarias": 45,
      "Presión alta": 46,
      "Palpitaciones": 47,
      "Latidos rápidos": 48,
      "Sangrado nasal": 50,
      "Infecciones frecuentes": 51,
      "Ganglios inflamados": 52,
      "Heridas que no sanan": 53,
      "Resfriados constantes": 54,
      "Problemas de cicatrización": 55,
      "Pérdida del olfato": 56,
      "Pérdida del gusto": 57,
      "Inquietud": 58,
      "Tensión": 59,
      "Pérdida de sueño": 60,
      "Debilidad": 61,
      "Piel pálida": 62,
      "Dolor en el área": 63,
      "Sangrado": 64,
    };

    // Convertir los síntomas seleccionados a IDs
    List<int> sintomasSeleccionados =
        _selectedSymptoms.map((s) => sintomasIds[s]!).toList();

    // Llamar al método de la API
    Map<String, String> resultado =
      await ApiService().obtenerEnfermedadYRecomendacion(
      sintomasSeleccionados: sintomasSeleccionados,
      edad: edad,
      diasSintomas: diasSintomas,
    );

    // Mostrar el diálogo con los resultados
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.accent,
          contentPadding: const EdgeInsets.all(15.0),
          title: const Text(
            'Resultado del Diagnóstico',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Posibilidad: ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: resultado['enfermedad'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Recomendación: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: resultado['recomendacion'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _ageController.clear();
                    _daysController.clear();
                    _selectedSymptoms.clear();
                    _selectedCategory = null;
                    _searchController.clear();
                    _suggestedSymptoms.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  '      GRACIAS      ',
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
}
