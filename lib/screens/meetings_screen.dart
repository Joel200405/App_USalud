import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../services/category.dart';
import '../services/api_service.dart'; // Asegúrate de importar ApiService
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll('/', ''); // Removemos cualquier "/"

    if (newValue.selection.baseOffset == 0) {
      return newValue; // Permite borrar sin restricciones
    }

    StringBuffer formattedText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        formattedText
            .write('/'); // Insertar "/" en las posiciones correspondientes
      }
      formattedText.write(text[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class HourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remueve cualquier ":" existente para manipular solo los dígitos
    final text = newValue.text.replaceAll(':', '');

    // Permite borrar sin restricciones
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    StringBuffer formattedText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      // Inserta ":" después de los primeros dos dígitos (horas)
      if (i == 2) {
        formattedText.write(':');
      }
      formattedText.write(text[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

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
    _fetchCategoriesS(); // Carga las categorías al inicio
  }

  Future<void> _fetchCategoriesS() async {
    ApiService apiService = ApiService();
    List<Category> categories = await apiService
        .fetchCategoriesS(); // Asegúrate de que esta función devuelva una lista de objetos Category
    setState(() {
      _categories = categories;
    });
  }


  // Método para buscar síntomas en tiempo real
  void _onSearchSymptoms(String query) async {
    if (query.isNotEmpty) {
      try {
        _suggestedSymptoms = await ApiService().buscarServicios(query);
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
          'Agentar Cita',
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
              borderRadius:
                  BorderRadius.all(Radius.circular(16.0)), // Bordes redondeados
            ),
            onSelected: (String route) {
              Navigator.pushNamed(context, route);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '/login',
                child: Row(
                  children: [
                    Icon(Icons.login,
                        color: AppColors.white), // Ícono de inicio de sesión
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
            hintText: 'Busca aquí la especialidad',
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
          _buildSpecialtySelector(),
          const SizedBox(height: 20),
          _buildClinicSelector(),
          const SizedBox(height: 20),
          _buildDNIInput(),
          const SizedBox(height: 20),
          _buildReasonInput(),
          const SizedBox(height: 20),
          _buildDateInput(),
          const SizedBox(height: 20),
          _buildHourInput(),
          const SizedBox(height: 20),
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
          'Buscar especialidad por categoría:',
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

  Widget _buildSpecialtySelector() {
    if (_selectedCategory == null)
      return const SizedBox(); // No mostrar nada si no hay categoría seleccionada

    // Aquí se utiliza una variable para almacenar síntomas
    List<String> _currentSymptoms = [];

    return FutureBuilder<List<String>>(
      future: ApiService().fetchServicesByCategory(_selectedCategory!.id),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error al obtener especialidades: ${snapshot.error}');
        } else if (snapshot.hasData) {
          _currentSymptoms = snapshot.data!;

          // Ordena los síntomas de menor a mayor longitud
          _currentSymptoms.sort((a, b) => a.length.compareTo(b.length));
        } else {
          return const Text('No se encontraron especialidades.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seleccione tu especialidad:',
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

  // Declara _selectedClinicName como String? en lugar de Clinica?
String? _selectedClinicName;

Widget _buildClinicSelector() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Seleccione un centro de salud:',
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
              Icons.grid_view, // Ícono para el selector
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButton2<String>(
                value: _selectedClinicName,
                hint: const Text(
                  'Seleccione para su atención',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Clínica ConfíaSalud',
                    child: const Text(
                      'Clínica ConfíaSalud',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Clínica Ortega',
                    child: const Text(
                      'Clínica Ortega',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Clínica Zarate',
                    child: const Text(
                      'Clínica Zarate',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Clínica Rebagliati',
                    child: const Text(
                      'Clínica Rebagliati',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Clínica Chenet',
                    child: const Text(
                      'Clínica Chenet',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Santo Domingo',
                    child: const Text(
                      'Santo Domingo',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'D. Alcides Carrión',
                    child: const Text(
                      'D. Alcides Carrión',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'El Carmen',
                    child: const Text(
                      'El Carmen',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedClinicName = newValue;
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


  Widget _buildDNIInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrese el N° de documento:',
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
            hintText: 'Su número aquí',
            hintStyle: TextStyle(
              color: Colors.grey, // Color del hint
              fontWeight: FontWeight.bold, // Peso de la fuente del hint
              fontFamily: 'Poppins', // Familia de la fuente del hint
              fontSize: 16, // Tamaño de la fuente del hint
            ),
            prefixIcon:
                Icon(Icons.account_circle, color: Colors.grey), // Ícono de la lupa
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

  Widget _buildReasonInput() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingrese una breve explicación:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.secondary,
          keyboardType: TextInputType.text,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Su explicación aquí',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            prefixIcon: Icon(Icons.notes, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrese una fecha (12/12/2024):',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _dateController,
          inputFormatters: [DateInputFormatter()],
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.secondary,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'DD/MM/AAAA',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            prefixIcon: const Icon(Icons.today, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingrese una hora (12:34):',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          inputFormatters: [HourInputFormatter()],
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          cursorColor: AppColors.secondary,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'HH:MM',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            prefixIcon: const Icon(Icons.access_time, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
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
        'AGENDAR CITA',
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

void _submitForm() {
  _showDialog(
    context,
    'Cita agendada', // Título del diálogo
    'Su cita ha sido agendada exitosamente.' // Mensaje del diálogo
  );
}

// Función para mostrar la notificación con estilo personalizado
void _showDialog(BuildContext context, String title, String message) {
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

}
