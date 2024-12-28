import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Profile/rent_car_info_next_screen.dart';

class RentCarScreen extends StatefulWidget {
  const RentCarScreen({super.key});

  @override
  _RentCarScreenState createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carMileageController = TextEditingController();
  final _carPriceController = TextEditingController();
  final String _imagePath = ''; // For image path, initially empty

  // Function to navigate to the next screen
  void _navigateToNextScreen() {
    if (_carMakeController.text.isNotEmpty &&
        _carModelController.text.isNotEmpty &&
        _carYearController.text.isNotEmpty &&
        _carMileageController.text.isNotEmpty &&
        _carPriceController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RentCarSaleInfoScreen(
            carMake: _carMakeController.text,
            carModel: _carModelController.text,
            carYear: _carYearController.text,
            carMileage: _carMileageController.text,
            carPrice: _carPriceController.text,
            imagePath: _imagePath, // Pass empty string if no image is selected
          ),
        ),
      );
    } else {
      // Optional: Show a message if the fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields!')),
      );
    }
  }

  // Function to pick an image (currently optional)
  Future<void> _pickImage() async {
    // If you decide to implement image picker functionality later, you can do it here.
    // For now, leaving it empty allows you to proceed without uploading an image.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28435A),
        title: const Text("Add Car for Sale"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image Upload Section (Optional, doesn't block navigation)
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: _imagePath.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 50,
                          ),
                        )
                      : Image.asset(_imagePath),
                ),
              ),
              const SizedBox(height: 20),

              // Car Make TextField
              TextField(
                controller: _carMakeController,
                decoration: const InputDecoration(
                  labelText: 'Car Make',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Car Model TextField
              TextField(
                controller: _carModelController,
                decoration: const InputDecoration(
                  labelText: 'Car Model',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Car Year TextField
              TextField(
                controller: _carYearController,
                decoration: const InputDecoration(
                  labelText: 'Car Year',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Car Mileage TextField
              TextField(
                controller: _carMileageController,
                decoration: const InputDecoration(
                  labelText: 'Car Mileage (in miles)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Car Price TextField
              TextField(
                controller: _carPriceController,
                decoration: const InputDecoration(
                  labelText: 'Car Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Button to go to next screen
              ElevatedButton(
                onPressed: _navigateToNextScreen,
                child: const Text("Save Information"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
