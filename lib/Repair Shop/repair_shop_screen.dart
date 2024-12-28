import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/components/animated_circles.dart';

class RepairShopScreen extends StatefulWidget {
  const RepairShopScreen({super.key});

  @override
  State<RepairShopScreen> createState() => _RepairShopScreenState();
}

class _RepairShopScreenState extends State<RepairShopScreen> {
  // Async function to clean up resources when back button is pressed
  Future<bool> _onBackPressed() async {
    // Return true to allow default back navigation
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed, // Intercept back press and handle cleanup
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shops Nearby'),
        ),
        body: const AnimatedCircles(),
      ),
    );
  }
}
