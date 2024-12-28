import 'dart:io';

import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Profile/sale_care_info_next_screen.dart';
import 'package:image_picker/image_picker.dart'; // Add image picker package

class SellCarScreen extends StatefulWidget {
  const SellCarScreen({super.key});

  @override
  _SellCarScreenState createState() => _SellCarScreenState();
}

class _SellCarScreenState extends State<SellCarScreen> {
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _carMileageController = TextEditingController();
  final _carPriceController = TextEditingController();
  final String _imagePath = ''; // For image path, initially empty
  bool isFormValid = false; // To track form validation

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
          builder: (context) => CarSaleInfoScreen(
            carMake: _carMakeController.text,
            carModel: _carModelController.text,
            carYear: _carYearController.text,
            carMileage: _carMileageController.text,
            carPrice: _carPriceController.text,
            imagePath: _imagePath,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields and upload an image!')),
      );
    }
  }

  // Function to validate form fields
  void _validateForm() {
    setState(() {
      isFormValid = _carMakeController.text.isNotEmpty &&
          _carModelController.text.isNotEmpty &&
          _carYearController.text.isNotEmpty &&
          _carMileageController.text.isNotEmpty &&
          _carPriceController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
        title: const Text("Add Car for Sale"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image Upload Section
              GestureDetector(
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
                      : Image.file(
                          File(_imagePath),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Car Make TextField with validation
              TextField(
                controller: _carMakeController,
                onChanged: (value) => _validateForm(),
                decoration: const InputDecoration(
                  labelText: 'Car Make',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                      Icons.directions_car), // Icon for added interactivity
                ),
              ),
              const SizedBox(height: 16),

              // Car Model TextField
              TextField(
                controller: _carModelController,
                onChanged: (value) => _validateForm(),
                decoration: const InputDecoration(
                  labelText: 'Car Model',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.model_training),
                ),
              ),
              const SizedBox(height: 16),

              // Car Year TextField
              TextField(
                controller: _carYearController,
                onChanged: (value) => _validateForm(),
                decoration: const InputDecoration(
                  labelText: 'Car Year',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 16),

              // Car Mileage TextField
              TextField(
                controller: _carMileageController,
                onChanged: (value) => _validateForm(),
                decoration: const InputDecoration(
                  labelText: 'Car Mileage (in miles)',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.speed),
                ),
              ),
              const SizedBox(height: 16),

              // Car Price TextField
              TextField(
                controller: _carPriceController,
                onChanged: (value) => _validateForm(),
                decoration: const InputDecoration(
                  labelText: 'Car Price',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 16),

              // Button to go to next screen, with interactivity based on form validation
              ElevatedButton(
                onPressed: isFormValid ? _navigateToNextScreen : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid
                      ? const Color(0xFF28435A)
                      : Colors.grey, // Disabled state
                ),
                child: const Text("Save Information"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
