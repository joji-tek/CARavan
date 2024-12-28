// custom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:user1_bookingrepair/HomePage/home_page_screen.dart';
import 'package:user1_bookingrepair/Message/Message_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/repairshop_first_screen.dart';
import 'package:user1_bookingrepair/Transaction/transaction_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/repair_shop_screen.dart';

class CustomNavBar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamically calculate size based on screen dimensions
    final navBarHeight = screenHeight * 0.08; // 8% of screen height
    final circleNavWidth = screenWidth * 0.15; // 15% of screen width
    final padding =
        screenWidth * 0.01; // Padding as a percentage of screen width
    final cornerRadius =
        screenWidth * 0.03; // Radius as a percentage of screen width

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CircleNavBar(
        activeIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.car_repair, color: Colors.white),
          Icon(Icons.receipt, color: Colors.white),
        ],
        inactiveIcons: const [
          Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Message",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Repair Shop",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Transaction",
            style: TextStyle(color: Colors.white),
          ),
        ],
        color: const Color(0xFF28435A),
        circleColor: const Color(0xFF28435A),
        height: navBarHeight,
        circleWidth: circleNavWidth,
        activeIndex: activeIndex,
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              // Navigate to Home screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePageScreen()),
              );
              break;
            case 1:
              // Navigate to Message screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessageScreen()),
              );
              break;
            case 2:
              // Navigate to Repair Shop screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RepairHome()),
              );
              break;
            case 3:
              final double totalAmount = 0.0;
              final int bookingId = 0;
              final bool isTransactionSuccessful = false;
              final String? issueDescription = '';
              // Navigate to Transaction screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionScreen()),
              );
              break;
          }
          onTap(index); // Call the onTap callback passed from the parent widget
        },
        padding: EdgeInsets.symmetric(horizontal: padding),
        cornerRadius: BorderRadius.circular(cornerRadius),
        circleShadowColor: const Color(0xFF28435A),
        elevation: 10,
      ),
    );
  }
}
