import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user1_bookingrepair/Repair%20Shop/Payment/booking_payment_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/set_appointment/payment/appointment_payment_screen.dart';
import 'package:user1_bookingrepair/helper/RepairShop/dbhelper_appointment.dart';

class CarRepairAppointmentScreen extends StatefulWidget {
  const CarRepairAppointmentScreen({super.key});

  @override
  _CarRepairAppointmentScreenState createState() =>
      _CarRepairAppointmentScreenState();
}

class _CarRepairAppointmentScreenState
    extends State<CarRepairAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _carModelController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _issueDescriptionController = TextEditingController();

  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _driversLicenseController = TextEditingController();

  final _datePickerController = TextEditingController();
  final _timePickerController = TextEditingController();

  final _additionalNotesController = TextEditingController();

  String? _selectedIssue;
  List<Map<String, dynamic>> homeVisitIssues = [
    {'name': 'Brake Repair', 'price': 1200},
    {'name': 'Transmission Issues', 'price': 1500},
    {'name': 'Oil Change', 'price': 600},
    {'name': 'Battery Jumpstart', 'price': 400},
    {'name': 'Air Filter Replacement', 'price': 300},
  ];

  List<Map<String, dynamic>> visitShopIssues = [
    {'name': 'Flat Tire', 'price': 500},
    {'name': 'Engine Overheating', 'price': 1000},
    {'name': 'Battery Replacement', 'price': 800},
    {'name': 'Transmission Fluid Change', 'price': 750},
    {'name': 'Suspension Repair', 'price': 2000},
  ];

  String? _selectedService;
  DateTime _appointmentDate = DateTime.now();
  TimeOfDay _appointmentTime = TimeOfDay.now();

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
        _datePickerController.text = DateFormat('yyyy-MM-dd').format(_appointmentDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _appointmentTime,
    );
    if (pickedTime != null && pickedTime != _appointmentTime) {
      setState(() {
        _appointmentTime = pickedTime;
        _timePickerController.text = _appointmentTime.format(context);
      });
    }
  }

  void _confirmAppointment() {
  if (_formKey.currentState?.validate() ?? false) {
    double issuePrice = 0.0;
    if (_selectedService != null && _selectedIssue != null) {
      var issuesList = _selectedService == 'Visit Shop'
          ? visitShopIssues
          : homeVisitIssues;
      var selectedIssueData = issuesList.firstWhere(
        (issue) => issue['name'] == _selectedIssue,
        orElse: () => {'price': 0},
      );
      issuePrice = (selectedIssueData['price'] ?? 0.0).toDouble(); // Ensure it's a double
    }

    // Prepare the data to insert into the database
    Map<String, dynamic> appointmentData = {
      AppointmentsDBHelper.columnCarModel: _carModelController.text,
      AppointmentsDBHelper.columnLicensePlate: _licensePlateController.text,
      AppointmentsDBHelper.columnIssueDescription: _selectedIssue,
      AppointmentsDBHelper.columnServiceType: _selectedService,
      AppointmentsDBHelper.columnDriversLicense: _driversLicenseController.text,
      AppointmentsDBHelper.columnStreet: _streetController.text,
      AppointmentsDBHelper.columnCity: _cityController.text,
      AppointmentsDBHelper.columnState: _stateController.text,
      AppointmentsDBHelper.columnZipCode: _zipCodeController.text,
      AppointmentsDBHelper.columnCountry: _countryController.text,
      AppointmentsDBHelper.columnLandmark: _landmarkController.text,
      AppointmentsDBHelper.columnAppointmentDate: DateFormat('yyyy-MM-dd').format(_appointmentDate),
      AppointmentsDBHelper.columnAppointmentTime: _appointmentTime.format(context),
      AppointmentsDBHelper.columnAdditionalNotes: _additionalNotesController.text,
      AppointmentsDBHelper.columnPrice: issuePrice,
    };

    // Insert the appointment into the database
    AppointmentsDBHelper.instance.insertAppointment(appointmentData).then((id) {
      // After saving, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentPaymentScreen(
            issuePrice: issuePrice.toString(),
          ),
        ),
      );
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedService == null
              ? 'Car Repair Appointment'
              : 'Car Repair Appointment - $_selectedService',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedService,
                  hint: const Text('Select Service'),
                  items: ['Visit Shop', 'Request Home Visit'].map((service) {
                    return DropdownMenuItem<String>(
                      value: service,
                      child: Text(service),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedService = value;
                      _selectedIssue = null;  // Reset issue when service changes
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Service Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a service.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                // Issue Description Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedIssue,
                  hint: const Text('Select Issue Description'),
                  items: (_selectedService == 'Visit Shop'
                          ? visitShopIssues
                          : homeVisitIssues)
                      .map((issue) {
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
                  'Car Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                      return 'Please enter the license plate number.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Driver's License Field for Home Visit
                if (_selectedService == 'Request Home Visit') ...[
                  TextFormField(
                    controller: _driversLicenseController,
                    decoration: const InputDecoration(
                      labelText: 'Driver\'s License',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the driver\'s license number.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Location Fields for Home Visit
                  const Text(
                    'Location Details:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
                        return 'Please enter the state/province.';
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
                ],

                // Appointment Date and Time Picker
                const Text(
                  'Appointment Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _datePickerController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Date of Appointment',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _timePickerController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Time of Appointment',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  onTap: () => _selectTime(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a time.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Additional Notes Field
                TextFormField(
                  controller: _additionalNotesController,
                  decoration: const InputDecoration(
                    labelText: 'Additional Notes (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _confirmAppointment,
                  child: const Text('Confirm Appointment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
