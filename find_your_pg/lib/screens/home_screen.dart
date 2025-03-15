import 'package:find_pg_rooms/screens/home.dart';
import 'package:find_pg_rooms/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    Home(),
    const Center(
      child: Text("Favorites Screen", style: TextStyle(fontSize: 20)),
    ),
    const ProfileScreen(), // Navigate to Profile Screen
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of Screens

    // Function to change index on tap

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Find Your PG",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF7B1FA2),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Future: Open search functionality
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF7B1FA2),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 237, 144, 254),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        // Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileScreen())),
      ),
    );
  }
}
