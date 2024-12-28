import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/HomePage/Car%20Parts/ar_screen.dart';
import 'package:user1_bookingrepair/HomePage/Car%20Parts/booking_screen.dart';
import 'package:user1_bookingrepair/NavBar/custom_nav_bar.dart';
import 'package:user1_bookingrepair/Profile/user1.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;
  int _selectedCategoryIndex =
      0; // Index to track the selected category (For Sale, For Rent, Car Parts)

  List<Map<String, dynamic>> parts = [
    {
      "name": "LED Tail Lights",
      "price": 500,
      "description":
          "Enhance your vehicle's style and performance with our high-quality wheel rims. Designed for durability and precision, they improve handling while giving your car a sleek, modern look.",
      "imageUrl":
          "https://iriga.gov.ph/wp-content/uploads/2022/11/placeholder.png",
      "category": "Car Parts",
    },
    {
      "name": "Front Grill Cover",
      "price": 2000,
      "description":
          "Upgrade your vehicle with our premium front grille, designed to optimize airflow and enhance engine cooling. Perfect for maintaining ideal temperatures and ensuring peak performance.",
      "imageUrl":
          "https://iriga.gov.ph/wp-content/uploads/2022/11/placeholder.png",
      "category": "Car Parts",
    },
    // Add more items for "For Sale" and "For Rent"
  ];

  List<String> categories = [
    "For Sale",
    "For Rent",
    "Car Parts"
  ]; // Categories for the toggle buttons

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredParts = parts
        .where((part) => part["category"] == categories[_selectedCategoryIndex])
        .toList(); // Filter parts based on the selected category

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(46, 67, 90, 1),
        toolbarHeight: MediaQuery.of(context).size.height / 5,
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => MyHomePage()));
                      },
                      child: ClipOval(
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.network(
                            'https://media.themoviedb.org/t/p/w300_and_h450_bestv2/zqBT16EdgLX9ToPwU6qhuY09QBI.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 30,
                      child: Image.asset(
                        'assets/images/LogoType.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    label: const Text('Search any car...'),
                    labelStyle: const TextStyle(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header Container
            // Container(
            //   color: const Color(0xFF28435A),
            //   width: double.infinity,
            //   height: 148,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => const MyHomePage()),
            //                 );
            //               },
            //               child: ClipOval(
            //                 child: Image.network(
            //                   "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/zqBT16EdgLX9ToPwU6qhuY09QBI.jpg",
            //                   width: 60.0,
            //                   height: 60.0,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ),
            //             Image.network(
            //               "https://iriga.gov.ph/wp-content/uploads/2022/11/placeholder.png",
            //               width: 60.0,
            //               height: 60.0,
            //               fit: BoxFit.cover,
            //             ),
            //           ],
            //         ),
            //       ),
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.5,
            //         height: 35,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(30),
            //         ),
            //         child: const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Row(
            //             children: [
            //               Icon(Icons.search),
            //               SizedBox(width: 10),
            //               Text('Search any parts...'),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Toggle Buttons for category selection

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                isSelected: List.generate(categories.length,
                    (index) => _selectedCategoryIndex == index),
                onPressed: (int index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
                selectedColor: Colors.white,
                selectedBorderColor: Colors.white,
                fillColor: const Color(0xFF28435A),
                children: categories
                    .map((category) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(category),
                        ))
                    .toList(),
              ),
            ),

            // GridView with Car Parts
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = (constraints.maxWidth / 200).floor();
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount > 1
                            ? crossAxisCount
                            : 2, // Ensure at least 2 columns
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: filteredParts.length,
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(95, 171, 171, 171),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 15.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 100,
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ARScanningScreen(
                                              imageUrl: filteredParts[index]
                                                  ["imageUrl"],
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          filteredParts[index]["imageUrl"],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredParts[index]["name"],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Php ${filteredParts[index]["price"]}',
                                            style: const TextStyle(fontSize: 8),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingScreen(
                                                partName: filteredParts[index]
                                                    ["name"],
                                                partPrice: filteredParts[index]
                                                    ["price"],
                                                partDescription:
                                                    filteredParts[index]
                                                        ["description"],
                                                imageUrl: filteredParts[index]
                                                    ["imageUrl"],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF28435A),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
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
}
