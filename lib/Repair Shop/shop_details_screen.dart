import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Repair%20Shop/booking/booknow_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/set_appointment/set_appointment_screen.dart';
import 'package:user1_bookingrepair/Message/message_convo_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/booking/visit_choices.dart';
import 'package:user1_bookingrepair/Repair%20Shop/repairshop_first_screen.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanic User'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RepairHome(), // Specify the screen you want to navigate to
              ),
            );
          }, 
          icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Image
            Padding(
              padding: const EdgeInsets.all(12.0), // Reduced padding
              child: Card(
                margin: const EdgeInsets.all(16),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0), // Reduced radius
                  child: Image.network(
                    'https://gwrench.com/wp-content/uploads/2022/02/CarRepairShopsNearMeOceanside.jpg',
                    width: double.infinity,
                    height: screenHeight * 0.28, // Slightly reduced height
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15), // Reduced height
            // Container for all the details and footer sections
            Container(
              padding: const EdgeInsets.all(12.0), // Reduced padding
              decoration: BoxDecoration(
                color: const Color(0xFF28435A),
                borderRadius: BorderRadius.circular(6), // Reduced radius
              ),
              child: Column(
                children: [
                  // Details Card
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15), // Reduced margin
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0), // Reduced padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Location: 123 Street, City',
                            style: TextStyle(fontSize: 14), // Reduced font size
                          ),
                          const SizedBox(height: 8), // Reduced height
                          const Text(
                            'Opening Hours: 9:00 AM - 8:00 PM',
                            style: TextStyle(fontSize: 14), // Reduced font size
                          ),
                          const SizedBox(height: 12), // Reduced height
                          const Text(
                            'Reviews:',
                            style: TextStyle(
                              fontSize: 16, // Reduced font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Reduced height
                          ...List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0), // Reduced padding
                              child: Text(
                                '- Review $index: Great service!',
                                style: TextStyle(
                                  fontSize: 12, // Reduced font size
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12), // Reduced height
                  // Footer Area
                  Padding(
                    padding: const EdgeInsets.all(11.0), // Reduced padding
                    child: Column(
                      children: [
                        // Profile Row
                        Row(
                          children: [
                            // Profile Image
                            CircleAvatar(
                              radius: screenWidth * 0.08, // Reduced size
                              backgroundImage: const NetworkImage(
                                'https://conceptualminds.com/wp-content/uploads/2022/08/Wiygul-Auto-Shop-Exterior.jpg',
                              ),
                            ),
                            const SizedBox(width: 12), // Reduced width
                            // Message Icon and Price Range
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Price Range: ₱500 - ₱1,500',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Colors.white), // Reduced font size
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return const MessageConvoScreen();
                                      }));
                                    },
                                    icon: const Icon(Icons.message,
                                        size: 24,
                                        color:
                                            Colors.white), // Reduced icon size
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Reduced height
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const CarRepairBookingScreen(); // Ensure the widget is properly instantiated
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth * 0.06, // Reduced padding
                                  vertical:
                                      screenHeight * 0.015, // Reduced padding
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black
                              ),
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                    fontSize: 14), // Reduced font size
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return  CarRepairAppointmentScreen(); // Ensure the widget is properly instantiated
                                  },
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth * 0.06, // Reduced padding
                                  vertical:
                                      screenHeight * 0.015, // Reduced padding
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black
                              ),
                              child: const Text(
                                'Set Appointment',
                                style: TextStyle(
                                    fontSize: 14), // Reduced font size
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
