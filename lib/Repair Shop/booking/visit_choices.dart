import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Repair%20Shop/set_appointment/set_appointment_screen.dart';

class VisitChoices extends StatelessWidget {
  VisitChoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Options'),
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Visit Shop Card
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  // Navigate to next screen with value 0 for "Visit Shop"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarRepairAppointmentScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 250,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF28435A),
                  ),
                  child: const Center(
                    child: Text(
                      'Visit Shop',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Request Home Visit Card
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  // Navigate to next screen with value 1 for "Request Home Visit"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarRepairAppointmentScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 250,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF28435A),
                  ),
                  child: const Center(
                    child: Text(
                      'Request Home Visit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  final int value;

  const NextScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    String selectedOption = value == 0 ? 'Visit Shop' : 'Request Home Visit';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Selection'),
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'You selected: $selectedOption',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VisitChoices(),
  ));
}
