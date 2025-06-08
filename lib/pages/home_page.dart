import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> places;

  @override
  void initState() {
    super.initState();
    places = ApiService.fetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EDF6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi Guy!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Where are you going next?",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search your destination",
                        border: InputBorder.none,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Button Row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton("Hotels", Icons.location_city, Colors.orange.shade100),
                  _buildFilterButton("Flights", Icons.flight, Colors.pink.shade100),
                  _buildFilterButton("All", Icons.public, Colors.teal.shade100),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Popular Destinations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),

            SizedBox(height: 8),

            // Horizontal list
            Expanded(
              child: FutureBuilder<List<Place>>(
                future: places,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  if (snapshot.hasError)
                    return Center(child: Text('Lỗi: ${snapshot.error}'));

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8, // chỉnh cao/thấp tùy ý
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final place = snapshot.data![index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                place.imageAsset,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey[300],
                                  child: Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.favorite, color: Colors.redAccent),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(place.name,
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow, size: 16),
                                        SizedBox(width: 4),
                                        Text(place.rating.toString(),
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Bottom nav (optional)
            BottomNavigationBar(
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title, IconData icon, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 16),
          SizedBox(width: 6),
          Text(title),
        ],
      ),
    );
  }
}
