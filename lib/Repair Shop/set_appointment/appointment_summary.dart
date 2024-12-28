import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user1_bookingrepair/Repair%20Shop/set_appointment/payment/appointment_payment_screen.dart'; // Import the intl package for date formatting

class AppointmentSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> appointmentData;

  const AppointmentSummaryScreen({Key? key, required this.appointmentData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the DateTime objects if necessary
    String formattedDate = DateFormat('yyyy-MM-dd').format(appointmentData['appointmentDate']);
    String formattedTime = DateFormat('HH:mm').format(appointmentData['appointmentTime']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Summary'),
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 59, 84, 105),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Details Header
              Text(
                'Car Details',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Car Details Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          appointmentData['carModel'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Car Model'),
                      ),
                      ListTile(
                        title: Text(
                          appointmentData['licensePlate'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('License Plate'),
                      ),
                    ],
                  ),
                ),
              ),
              // Issue Description & Price Header
              Text(
                'Issue Details',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Issue Details Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          appointmentData['issueDescription'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Issue Description'),
                      ),
                      ListTile(
                        title: Text(
                          '₱${appointmentData['price']}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Service Price'),
                      ),
                    ],
                  ),
                ),
              ),
              // Appointment Date & Time Header
              Text(
                'Appointment Details',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Appointment Date & Time Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          formattedDate, // Use the formatted date
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Appointment Date'),
                      ),
                      ListTile(
                        title: Text(
                          formattedTime, // Use the formatted time
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Appointment Time'),
                      ),
                    ],
                  ),
                ),
              ),
              // Service Location & Other Details Header
              Text(
                'Location & Additional Notes',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Location & Notes Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (appointmentData['serviceType'] == 'Request Home Visit') ...[
                        ListTile(
                          title: Text(
                            '${appointmentData['location']['street']}, ${appointmentData['location']['city']}, ${appointmentData['location']['state']}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: const Text('Location'),
                        ),
                        if (appointmentData['location']['landmark'] != null && appointmentData['location']['landmark']!.isNotEmpty)
                          ListTile(
                            title: Text(
                              appointmentData['location']['landmark'],
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            subtitle: const Text('Landmark'),
                          ),
                      ],
                      ListTile(
                        title: Text(
                          appointmentData['additionalNotes'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Additional Notes'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Confirm Appointment Button
              // In the AppointmentSummaryScreen
              ElevatedButton(
                onPressed: () {
                  // Pass the issue price and other necessary data to AppointmentPaymentScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentPaymentScreen(
                        issuePrice: appointmentData['price'].toString(), // Pass the issue price from appointmentData
                      ),
                    ),
                  );
                },
                child: const Text('Confirm Appointment'),
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  minimumSize: Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF28435A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
