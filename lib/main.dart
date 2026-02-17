import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Tours',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ToursHomePage(),
    );
  }
}

class ToursHomePage extends StatefulWidget {
  const ToursHomePage({super.key});

  @override
  State<ToursHomePage> createState() => _ToursHomePageState();
}

class _ToursHomePageState extends State<ToursHomePage> {
  int _selectedIndex = 1; // Seleccionado "Tours" por defecto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tours',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. SECCIÓN HERO (Imagen grande con buscador)
              _buildHeroSection(),

              const SizedBox(height: 25),

              // 2. TÍTULO "Podría interesarte"
              const Text(
                'Podría interesarte',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 15),

              // 3. TARJETAS DE CIUDADES (Barcelona, Tokio)
              _buildCityCard(
                cityName: 'Barcelona',
                imageUrl: 'https://images.unsplash.com/photo-1583422409516-2895a77efded?q=80&w=400&auto=format&fit=crop',
                activities: [
                  'La cocina de Barcelona de cerca',
                  'Espectáculos de flamenco y tapas',
                  'Tours guiados por la Sagrada...',
                ],
              ),

              const SizedBox(height: 15),

              _buildCityCard(
                cityName: 'Tokio',
                imageUrl: 'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?q=80&w=400&auto=format&fit=crop',
                activities: [
                  'Tradición y cultura del sumo',
                  'Monte Fuji con un guía privado',
                  'Prueba las delicias de mariscos...',
                ],
              ),
              
              // Espacio extra al final para que no tape el menu
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      
      // 4. BARRA DE NAVEGACIÓN INFERIOR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_outlined), // Icono similar a la flecha/pin
            label: 'Tours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Reseñas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Cuenta',
          ),
        ],
      ),
    );
  }

  // WIDGET AUXILIAR: El banner superior
  Widget _buildHeroSection() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=800&auto=format&fit=crop'), // Imagen playa
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Capa oscura para que se lea el texto blanco
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Reserva Cosas que hacer aprobadas por los viajeros',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 15),
                // Barra de búsqueda simulada
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Buscar por destino', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET AUXILIAR: Tarjeta de ciudad (Reutilizable)
  Widget _buildCityCard({
    required String cityName,
    required String imageUrl,
    required List<String> activities,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50, // Fondo muy sutil
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lado Izquierdo: Imagen con corazón
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, size: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Lado Derecho: Textos y lista de actividades
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                // Generamos la lista de etiquetas (pills)
                ...activities.map((activity) => Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Text(
                        activity,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}