import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Repair%20Shop/shop_details_screen.dart';
import 'package:user1_bookingrepair/components/nearby_shops_services.dart';

class AnimatedCircles extends StatefulWidget {
  const AnimatedCircles({Key? key}) : super(key: key);

  @override
  _AnimatedCirclesState createState() => _AnimatedCirclesState();
}

class _AnimatedCirclesState extends State<AnimatedCircles> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for smooth animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define the scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation
    _controller.repeat(reverse: true);

    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate data loading
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Outer Circle (applies scaling)
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Center(
                child: Container(
                  width: screenSize.width * 0.8 * _scaleAnimation.value,  // Apply scaling
                  height: screenSize.width * 0.8 * _scaleAnimation.value, // Apply scaling
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.7),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),

          // Animated Inner Circle (applies scaling)
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Center(
                child: Container(
                  width: screenSize.width * 0.5 * _scaleAnimation.value,  // Apply scaling
                  height: screenSize.width * 0.5 * _scaleAnimation.value, // Apply scaling
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.7),
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),

          // Scanning Animation (centered)
          if (isLoading)
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.withOpacity(0.5),
                child: const Icon(Icons.search, color: Colors.white, size: 50),
              ),
            ),

          // Show nearby shops (after scanning is finished)
          if (!isLoading)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context){
                                          return ShopDetails();
                                      }));
                    },
                    child: NearbyShopsServices(), // Example, replace with your widget
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
