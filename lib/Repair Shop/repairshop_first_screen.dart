import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Message/message_convo_screen.dart';
import 'package:user1_bookingrepair/NavBar/custom_nav_bar.dart';
import 'package:user1_bookingrepair/Repair%20Shop/repair_shop_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/shop_details_screen.dart';

class RepairHome extends StatefulWidget {
  const RepairHome({super.key});

  @override
  State<RepairHome> createState() => _RepairHomeState();
}

class _RepairHomeState extends State<RepairHome> {
  int _currentIndex = 2;

  // Lists for categories
  final List<String> recentShops = [];
  final List<String> popularShops = [];
  final List<String> nearbyShops = ['Mechanic - Urdaneta City'];

  void _addToRecent(String shop) {
    setState(() {
      if (!recentShops.contains(shop)) {
        recentShops.add(shop);
        print("Added to recent: $shop");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Shops'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const RepairShopScreen(),
            ));
          },
          icon: const Icon(Icons.search),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildCategoryTitle('Recent', recentShops),
            _buildShopList(recentShops, screenSize),
             SizedBox(height: 20),
             Divider(),
            SizedBox(height: 16),
            _buildCategoryTitle('Popular', popularShops),
            _buildShopList(popularShops, screenSize),
             SizedBox(height: 20),
             Divider(),
             SizedBox(height: 16),
            _buildCategoryTitle('Nearby', nearbyShops),
            _buildShopList(nearbyShops, screenSize),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        activeIndex: _currentIndex,
        onTap: (v) {
          setState(() {
            _currentIndex = v;
          });
        },
      ),
    );
  }

  Widget _buildCategoryTitle(String title, List<String> shops) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildShopList(List<String> shops, Size screenSize) {
    return Column(
      children: shops.map((shop) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            color: Colors.white70,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shop,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Icon(Icons.star_half, color: Colors.amber, size: 20),
                            const Icon(Icons.star_border, color: Colors.amber, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              '(4.5)',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _addToRecent(shop);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => const ShopDetails(),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF28435A),
                              ),
                              child: const Text(
                                'View Shop',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MessageConvoScreen(),
                                ));
                              },
                              icon: const Icon(
                                Icons.message,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://conceptualminds.com/wp-content/uploads/2022/08/Wiygul-Auto-Shop-Exterior.jpg',
                      width: screenSize.width * 0.3, // 30% of screen width
                      height: screenSize.width * 0.3, // Keep square aspect ratio
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
