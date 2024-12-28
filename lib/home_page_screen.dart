// // home_page_widget.dart

// import 'package:flutter/material.dart';
// import 'package:user1_bookingrepair/NavBar/custom_nav_bar.dart';
// import 'package:user1_bookingrepair/Repair%20Shop/shoplist_screen.dart';

// class HomePageWidget extends StatefulWidget {
//   const HomePageWidget({Key? key}) : super(key: key);

//   @override
//   State<HomePageWidget> createState() => _HomePageWidgetState();
// }

// class _HomePageWidgetState extends State<HomePageWidget> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   int _currentIndex = 1; // Default tab index
//   double _scale = 1.0; // Initial scale for circles
//   bool _zoomIn = true;

//   @override
//   void initState() {
//     super.initState();
//     _startZoomEffect();
//   }

//   void _startZoomEffect() {
//     Future.delayed(Duration.zero, () {
//       setState(() {
//         _scale = _zoomIn ? 1.2 : 1.0;
//         _zoomIn = !_zoomIn;
//       });
//       Future.delayed(const Duration(seconds: 1), _startZoomEffect);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           automaticallyImplyLeading: false,
//           title: const Align(
//             alignment: AlignmentDirectional(0, 0),
//             child: Text(
//               'Shops Nearby',
//               style: TextStyle(
//                 fontFamily: 'Inter Tight',
//                 color: Colors.black,
//                 fontSize: 22,
//                 letterSpacing: 0.0,
//               ),
//             ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: SafeArea(
//           child: Center(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Outer Circle
//                 AnimatedScale(
//                   duration: const Duration(seconds: 1),
//                   scale: _scale,
//                   child: Container(
//                     width: screenWidth * 0.9, // 90% of screen width
//                     height: screenWidth * 0.9, // Maintain circular shape
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.black.withOpacity(0.7),
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Inner Circle
//                 AnimatedScale(
//                   duration: const Duration(seconds: 1),
//                   scale: _scale,
//                   child: Container(
//                     width: screenWidth * 0.6, // 60% of screen width
//                     height: screenWidth * 0.6,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.black.withOpacity(0.7),
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Avatar
//                 CircleAvatar(
//                   radius: screenWidth * 0.2, // 20% of screen width
//                   backgroundImage: const NetworkImage(
//                     'https://media.themoviedb.org/t/p/w300_and_h450_bestv2/zqBT16EdgLX9ToPwU6qhuY09QBI.jpg',
//                   ),
//                 ),
                
//                 // Navigate Button
//                 Align(
//                   alignment: const AlignmentDirectional(0.01, 0.79),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (BuildContext context) {
//                           return const ShopList();
//                         },
//                       ));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.04, // 4% of screen width
//                         vertical: screenHeight * 0.02, // 2% of screen height
//                       ),
//                       backgroundColor: const Color(0xFF28435A),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Navigate',
//                       style: TextStyle(
//                         fontFamily: 'Inter Tight',
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: CustomNavBar(
         
//           activeIndex: _currentIndex,
//           onTap: (v) {
//             setState(() {
//               _currentIndex = v;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
