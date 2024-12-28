import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Message/message_convo_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/repairshop_first_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/shop_details_screen.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Shops'),
        centerTitle: true,
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RepairHome(), // Specify the screen you want to navigate to
              ),
            );
          }, 
          icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 1, // Example count of shops
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white70,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mechanic User',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Urdaneta City',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 20),
                              const Icon(Icons.star_half,
                                  color: Colors.amber, size: 20),
                              const Icon(Icons.star_border,
                                  color: Colors.amber, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                '(4.5)',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return const ShopDetails();
                                    }));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF28435A),
                                  ),
                                  child: const Text(
                                    'View Shop',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return const MessageConvoScreen();
                                    }));
                                  },
                                  icon: const Icon(
                                    Icons.message,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://conceptualminds.com/wp-content/uploads/2022/08/Wiygul-Auto-Shop-Exterior.jpg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
