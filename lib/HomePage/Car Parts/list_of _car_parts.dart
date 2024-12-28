// import 'package:flutter/material.dart';
// import 'package:user1_bookingrepair/HomePage/Car%20Parts/ar_screen.dart';
// import 'package:user1_bookingrepair/Profile/user1.dart';
// import 'booking_screen.dart';

// class ListOfCarParts extends StatelessWidget {
//   const ListOfCarParts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     List<Map<String, dynamic>> parts = [
//       {
//         "name": "LED Tail Lights",
//         "price": 500,
//         "description":
//             "Enhance your vehicle's style and performance with our high-quality wheel rims. Designed for durability and precision, they improve handling while giving your car a sleek, modern look.",
//         "imageUrl": "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
//       },
//       {
//         "name": "Front Grill Cover",
//         "price": 2000,
//         "description":
//             "Upgrade your vehicle with our premium front grille, designed to optimize airflow and enhance engine cooling. Perfect for maintaining ideal temperatures and ensuring peak performance.",
//         "imageUrl": "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
//       },
//     ];

//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             // Header Container
//             Container(
//               color: const Color(0xFF28435A),
//               width: double.infinity,
//               height: screenHeight * 0.2,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.05,
//                       vertical: 10,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const MyHomePage()),
//                             );
//                           },
//                           child: ClipOval(
//                             child: Image.asset(
//                               "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
//                               width: screenWidth * 0.15,
//                               height: screenWidth * 0.15,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Image.asset(
//                           "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
//                           width: screenWidth * 0.2,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.9,
//                     height: screenHeight * 0.06,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: const [
//                           Icon(Icons.search, color: Colors.grey),
//                           SizedBox(width: 10),
//                           Text('Search any parts...', style: TextStyle(color: Colors.grey)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // GridView with Car Parts
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: (screenWidth > 600) ? 3 : 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 3 / 4,
//                   ),
//                   itemCount: parts.length,
//                   itemBuilder: (context, index) {
//                     return GridTile(
//                       key: ValueKey(parts[index]["name"]),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: const Color.fromARGB(95, 171, 171, 171),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.25),
//                               blurRadius: 10.0,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ARScanningScreen(
//                                         imageUrl: parts[index]["imageUrl"],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   height: screenHeight * 0.15,
//                                   width: double.infinity,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     child: Image.network(
//                                       parts[index]["imageUrl"],
//                                       fit: BoxFit.cover,
//                                       loadingBuilder: (context, child, progress) {
//                                         return progress == null
//                                             ? child
//                                             : Center(child: CircularProgressIndicator());
//                                       },
//                                       errorBuilder: (context, error, stackTrace) {
//                                         return const Center(child: Icon(Icons.error, size: 40));
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 3),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Text(
//                                       '${parts[index]["name"]}\nPhp ${parts[index]["price"]}',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.left,
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => BookingScreen(
//                                             partName: parts[index]["name"],
//                                             partPrice: parts[index]["price"],
//                                             partDescription: parts[index]["description"],
//                                             imageUrl: parts[index]["imageUrl"],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                       width: screenWidth * 0.12,
//                                       height: screenWidth * 0.12,
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFF28435A),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: const Icon(
//                                         Icons.shopping_cart,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
