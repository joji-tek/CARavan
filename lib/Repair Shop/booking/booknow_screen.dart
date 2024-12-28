import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Repair%20Shop/booking/booking%20_details_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user1_bookingrepair/helper/RepairShop/dbheper_booking_repairshop.dart'; // Import the DBHelper class

class CarRepairBookingScreen extends StatefulWidget {
  const CarRepairBookingScreen({super.key});

  @override
  _CarRepairBookingScreenState createState() => _CarRepairBookingScreenState();
}

class _CarRepairBookingScreenState extends State<CarRepairBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form inputs
  final _carModelController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _issueDescriptionController = TextEditingController();

  final _streetController = TextEditingController();
  final _barangayController =
      TextEditingController(); // Added Barangay controller
  final _cityController = TextEditingController();
  final _provinceController =
      TextEditingController(); // Changed state to province
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _landmarkController = TextEditingController();

  final _additionalNotesController = TextEditingController();

  // Issue Description Dropdown
  String? _selectedIssue;
  String _selectedPrice = '';

  List<Map<String, dynamic>> issues = [
    {'name': 'Flat Tire', 'price': 500},
    {'name': 'Engine Overheating', 'price': 1000},
    {'name': 'Battery Replacement', 'price': 800},
    {'name': 'Brake Repair', 'price': 1200},
    {'name': 'Transmission Issues', 'price': 1500},
    {'name': 'Air Filter Issues', 'price': 200},
    {'name': 'Spark Plug Replacement', 'price': 300},
    {'name': 'Oil Leak', 'price': 400},
    {'name': 'Coolant Leak', 'price': 350},
    {'name': 'Exhaust System Issues', 'price': 600},
  ];

  Position? _currentLocation;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Location permission granted, proceed with location access
      _getCurrentLocation();
    } else if (status.isDenied) {
      // Permission denied, show a message or take necessary action
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Location permission is denied. Please enable it to proceed.")));
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, guide user to settings
      openAppSettings();
    }
  }

  // Method to get the current location
  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location services are disabled.')),
        );
        return;
      }

      // Check for location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permission denied.')),
          );
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Ensure the widget is still mounted before updating the state
      if (mounted) {
        setState(() {
          _currentLocation = position;
        });
        _getAddressFromCoordinates(position.latitude, position.longitude);
      }
    } catch (e) {
      // Handle errors (e.g., permission issues, service issues)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: $e')),
        );
      }
    }
  }

  // Method to get address from coordinates using reverse geocoding
  Future<void> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      // Get the address from the coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;

      setState(() {
        // Fill in the address fields with the retrieved values
        _streetController.text = place.street ?? 'Unknown street';
        _barangayController.text =
            place.subLocality ?? 'Unknown barangay'; // Added Barangay field
        _cityController.text = place.locality ?? 'Unknown city';
        _provinceController.text = place.administrativeArea ??
            'Unknown province'; // Changed to province
        _zipCodeController.text =
            place.postalCode ?? 'Unknown ZIP code'; // Populate ZIP code
        _countryController.text = place.country ?? 'Unknown country';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to get address: $e")),
      );
    }
  }

  // Method to insert data into the database
  Future<void> _saveBookingToDatabase() async {
    final dbHelper = DBHelper.instance;

    // Prepare data
    final booking = {
      'car_model': _carModelController.text,
      'license_plate': _licensePlateController.text,
      'issue_description': _selectedIssue,
      'price': _selectedPrice,
      'street': _streetController.text,
      'barangay': _barangayController.text,
      'city': _cityController.text,
      'province': _provinceController.text,
      'zip_code': _zipCodeController.text,
      'country': _countryController.text,
      'landmark': _landmarkController.text,
      'additional_notes': _additionalNotesController.text,
    };

    // Insert data into the database
    final result = await dbHelper.insertBooking(booking);
    // Debugging: Check if insert was successful
    if (result != null) {
      print('Booking inserted successfully with ID: $result');
    } else {
      print('Error inserting booking.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Repair Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Car Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _carModelController,
                  decoration: const InputDecoration(
                    labelText: 'Car Model',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car model.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _licensePlateController,
                  decoration: const InputDecoration(
                    labelText: 'License Plate',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the license plate.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                // Issue Description Dropdown
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedIssue,
                  hint: const Text('Select Issue Description'),
                  items: issues.map((issue) {
                    return DropdownMenuItem<String>(
                      value: issue['name'],
                      child: Text('${issue['name']} - ₱${issue['price']}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedIssue = value!;
                      _selectedPrice = issues
                          .firstWhere(
                              (issue) => issue['name'] == value)['price']
                          .toString();
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an issue description.';
                    }
                    return null;
                  },
                ),

                const Text(
                  'Service Location:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: _streetController,
                  decoration: const InputDecoration(
                    labelText: 'Street Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the street address.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _barangayController,
                  decoration: const InputDecoration(
                    labelText: 'Barangay',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the city.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _provinceController,
                  decoration: const InputDecoration(
                    labelText: 'Province',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the province.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'ZIP Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ZIP code.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the country.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: _landmarkController,
                  decoration: const InputDecoration(
                    labelText: 'Landmark (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _additionalNotesController,
                  decoration: const InputDecoration(
                    labelText: 'Additional Notes (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Check if issue is selected
                      if (_selectedIssue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Please select an issue description.")),
                        );
                        return;
                      }

                      // Save to database
                      await _saveBookingToDatabase();

                      // Navigate to the next screen with the actual data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailsScreen(
                            carModel: _carModelController.text,
                            licensePlate: _licensePlateController.text,
                            issueDescription: _selectedIssue!,
                            street: _streetController.text,
                            city: _cityController.text,
                            zipCode: _zipCodeController.text,
                            country: _countryController.text,
                            landmark: _landmarkController.text,
                            barangay: _barangayController.text,
                            province: _provinceController.text,
                            serviceProviderName:
                                '', // Pass service provider info if available
                            serviceProviderProfile: '',
                            isUrgent: true,
                            issuePrice: _selectedPrice,
                            isPaid: false,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
