import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        // Search Bar & Filter Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search PGs...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Color.fromARGB(202, 248, 206, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Future: Open filter options
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBA68C8),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.filter_list, color: Colors.white),
              ),
            ],
          ),
        ),

        // PG Listings
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5, // Dummy count for now
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "lib/assets/home.png", // Replace with real image
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: const Text(
                    "Luxury PG in XYZ Area",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("₹5000/month • Near College"),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Future: Save to favorites
                    },
                  ),
                  onTap: () {
                    // Future: Navigate to PG Details Screen
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
