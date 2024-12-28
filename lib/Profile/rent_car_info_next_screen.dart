import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Profile/sale_care_verify.dart';

class RentCarSaleInfoScreen extends StatelessWidget {
  final String carMake;
  final String carModel;
  final String carYear;
  final String carMileage;
  final String carPrice;
  final String imagePath;

  const RentCarSaleInfoScreen({
    super.key,
    required this.carMake,
    required this.carModel,
    required this.carYear,
    required this.carMileage,
    required this.carPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28435A),
        title: const Text("Car Sale Information"),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the next screen (CarPapersUploadScreen)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CarPapersUploadScreen()),
              );
            },
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image Upload Section
              GestureDetector(
                onTap: () {
                  // Placeholder for tap action, currently does nothing
                  print("Image tapped");
                },
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: imagePath.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 50,
                          ),
                        )
                      : Image.asset(imagePath), // Display image if selected
                ),
              ),
              const SizedBox(height: 20),

              // Car Make TextField (Read-Only)
              _buildCarInfoTextField('Car Make', carMake),
              const SizedBox(height: 16),

              // Car Model TextField (Read-Only)
              _buildCarInfoTextField('Car Model', carModel),
              const SizedBox(height: 16),

              // Car Year TextField (Read-Only)
              _buildCarInfoTextField('Car Year', carYear),
              const SizedBox(height: 16),

              // Car Mileage TextField (Read-Only)
              _buildCarInfoTextField('Car Mileage (in miles)', carMileage),
              const SizedBox(height: 16),

              // Car Price TextField (Read-Only)
              _buildCarInfoTextField('Car Price', carPrice),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarInfoTextField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value), // Set initial value
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      enabled: false, // Make it read-only
    );
  }
}
