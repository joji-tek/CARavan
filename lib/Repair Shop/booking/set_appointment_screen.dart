import 'package:flutter/material.dart';

class CarRepairAppointmentScreen extends StatefulWidget {
  const CarRepairAppointmentScreen({super.key});

  @override
  _CarRepairAppointmentScreenState createState() =>
      _CarRepairAppointmentScreenState();
}

class _CarRepairAppointmentScreenState
    extends State<CarRepairAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form inputs
  final _carModelController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _issueDescriptionController = TextEditingController();

  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _landmarkController = TextEditingController();

  final _additionalNotesController = TextEditingController();

  // Issue Description Dropdown
  String? _selectedIssue;
  List<Map<String, dynamic>> issues = [
    {'name': 'Flat Tire', 'price': 500},
    {'name': 'Engine Overheating', 'price': 1000},
    {'name': 'Battery Replacement', 'price': 800},
    {'name': 'Brake Repair', 'price': 1200},
    {'name': 'Transmission Issues', 'price': 1500},
  ];

  // Date and Time for Appointment
  DateTime _appointmentDate = DateTime.now();
  TimeOfDay _appointmentTime = TimeOfDay.now();

  // Method to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _appointmentDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != _appointmentDate) {
      setState(() {
        _appointmentDate = pickedDate;
      });
    }
  }

  // Method to show Time Picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _appointmentTime,
    );
    if (pickedTime != null && pickedTime != _appointmentTime) {
      setState(() {
        _appointmentTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Repair Appointment'),
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
                      _selectedIssue = value;
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
                const SizedBox(height: 16),
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
                  controller: _stateController,
                  decoration: const InputDecoration(
                    labelText: 'State/Province',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the state or province.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the zip code.';
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
                const SizedBox(height: 16),
                const Text(
                  'Appointment Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Appointment Date and Time
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Date: ${_appointmentDate.toLocal()}'.split(' ')[0],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _selectTime(context),
                        child: Text(
                          'Time: ${_appointmentTime.format(context)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Additional Notes (Optional):',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _additionalNotesController,
                  decoration: const InputDecoration(
                    labelText: 'Any additional details or requests?',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                // Price Display and Confirmation Buttons
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _selectedIssue == null
                        ? const SizedBox.shrink()
                        : Text(
                            'Estimated Price: ₱${issues.firstWhere((issue) => issue['name'] == _selectedIssue)['price']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate to the confirmation screen or process the appointment
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Booking Confirmation'),
                              content: Text(
                                'Your car repair appointment has been set for ${_appointmentDate.toLocal()} at ${_appointmentTime.format(context)}.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('CONFIRM APPOINTMENT'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28435A),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Clear the form
                        _formKey.currentState!.reset();
                        _carModelController.clear();
                        _licensePlateController.clear();
                        _issueDescriptionController.clear();
                        _streetController.clear();
                        _cityController.clear();
                        _stateController.clear();
                        _zipCodeController.clear();
                        _countryController.clear();
                        _landmarkController.clear();
                        _additionalNotesController.clear();
                      },
                      child: const Text('CANCEL'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
