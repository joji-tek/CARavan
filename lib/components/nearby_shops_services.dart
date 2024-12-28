import 'package:flutter/material.dart';

class NearbyShopsServices extends StatelessWidget {
  const NearbyShopsServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circle avatar for the image
        CircleAvatar(
          radius: 50, // Adjust the size as needed
          backgroundImage: NetworkImage(
            'https://conceptualminds.com/wp-content/uploads/2022/08/Wiygul-Auto-Shop-Exterior.jpg',
          ), // Replace with actual image URL
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
