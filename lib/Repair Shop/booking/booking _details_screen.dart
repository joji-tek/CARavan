import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Repair%20Shop/Payment/booking_payment_screen.dart';
import 'package:user1_bookingrepair/data/shop.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String carModel;
  final String licensePlate;
  final String issueDescription;
  final String street;
  final String barangay;
  final String city;
  final String province;
  final String zipCode;
  final String country;
  final String landmark;
  final String serviceProviderName;
  final String serviceProviderProfile;
  final bool isUrgent;
  final String issuePrice;
  final bool isPaid;
  late RepairShop selectedShop = repairShops[0];

  BookingDetailsScreen({
    required this.carModel,
    required this.licensePlate,
    required this.issueDescription,
    required this.street,
    required this.barangay,
    required this.city,
    required this.province,
    required this.zipCode,
    required this.country,
    required this.landmark,
    required this.serviceProviderName,
    required this.serviceProviderProfile,
    required this.isUrgent,
    required this.issuePrice,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(carModel,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Car Model'),
                      ),
                      ListTile(
                        title: Text(licensePlate,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
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
              // Issue Description & Price Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(issueDescription,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Issue Description'),
                      ),
                      ListTile(
                        title: Text(issuePrice,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Service Price'),
                      ),
                    ],
                  ),
                ),
              ),
              // Service Location Header
              Text(
                'Service Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Service Location Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(street,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Street Address'),
                      ),
                      ListTile(
                        title: Text(barangay,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Barangay'),
                      ),
                      ListTile(
                        title: Text(city,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('City'),
                      ),
                      ListTile(
                        title: Text(province,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Province'),
                      ),
                      ListTile(
                        title: Text(zipCode,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Zip Code'),
                      ),
                      ListTile(
                        title: Text(country,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Country'),
                      ),
                      ListTile(
                        title: Text(landmark.isEmpty ? 'N/A' : landmark,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Landmark'),
                      ),
                    ],
                  ),
                ),
              ),
              // Service Provider Header
              Text(
                'Service Provider',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Service Provider Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(selectedShop.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Provider Name'),
                      ),
                      ListTile(
                        title: Text(selectedShop.number,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Number'),
                      ),
                    ],
                  ),
                ),
              ),
              // Urgency Header
              Text(
                'Urgency Level',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              // Urgency Card
              Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(isUrgent ? 'Urgent' : 'Normal',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        subtitle: const Text('Urgency'),
                        tileColor: isUrgent
                            ? Colors.redAccent.withOpacity(0.1)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the payment screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        issuePrice: issuePrice,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  minimumSize: Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF28435A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
