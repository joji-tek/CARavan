import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/NavBar/custom_nav_bar.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        // Your screen content here
        child: Text('Home Page Content'),
      ),
      bottomNavigationBar: CustomNavBar(
        activeIndex: _currentIndex,
        onTap: (v) {
          setState(() {
            _currentIndex = v; // Update the index on tap
          });
        },
      ),
    );
  }
}
