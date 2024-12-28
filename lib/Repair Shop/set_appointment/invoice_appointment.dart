import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Transaction/transaction_screen.dart';
import 'package:user1_bookingrepair/data/shop.dart';
import 'package:user1_bookingrepair/data/user.dart';
import 'package:user1_bookingrepair/helper/RepairShop/dbhelper_appointment.dart';

class LatestAppointmentScreen extends StatefulWidget {
  const LatestAppointmentScreen({Key? key}) : super(key: key);

  @override
  _LatestAppointmentScreenState createState() =>
      _LatestAppointmentScreenState();
}

class _LatestAppointmentScreenState extends State<LatestAppointmentScreen> {
  late Map<String, dynamic> _latestAppointment;
  late RepairShop _selectedShop;
  late User _selectedUser;
  bool isTransactionSuccessful = false;
  bool isPaid = false;

  @override
  void initState() {
    super.initState();
    _latestAppointment = {};
    _selectedShop = repairShops[0]; // Example, use first repair shop
    _selectedUser = users[0]; // Example, use first user
    _fetchLatestAppointment();
  }

  // Fetch the latest appointment from the database
  Future<void> _fetchLatestAppointment() async {
    final allAppointments = await AppointmentsDBHelper.instance.getAppointments();
    if (allAppointments.isNotEmpty) {
      final latestAppointment = allAppointments.last; // Get the most recent one
      setState(() {
        _latestAppointment = latestAppointment;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the Transaction page when the back button is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TransactionScreen()
                ),
            );
          },
        ),
      ),
      body: _latestAppointment.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Personal Details',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                     _buildBookingDetailRow('User Name:', _selectedUser.name!),
                     _buildBookingDetailRow('Phone Number:', _selectedUser.contactNumber!),
                     SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 16),
                
                
                    // Repair Shop Details
                    Text(
                        'Shop Details',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    _buildBookingDetailRow('Shop Name:', _selectedShop.name!),
                     _buildBookingDetailRow('Location:', _selectedShop.location!),
                    _buildBookingDetailRow('Phone Number:', _selectedShop.number!),
                    _buildBookingDetailRow('Opening Hours:', _selectedShop.openingHours!),
                    SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 16),
                
                    // Appointment Details
                     Text(
                        'Shop Details',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                   _buildBookingDetailRow('Car Model:', _latestAppointment[AppointmentsDBHelper.columnCarModel]!),
                   _buildBookingDetailRow('License Plate:', _latestAppointment[AppointmentsDBHelper.columnLicensePlate]!),
                   _buildBookingDetailRow('Issue:', _latestAppointment[AppointmentsDBHelper.columnIssueDescription]!),
                   _buildBookingDetailRow('Service:', _latestAppointment[AppointmentsDBHelper.columnServiceType]!),
                   _buildBookingDetailRow('Date:', _latestAppointment[AppointmentsDBHelper.columnAppointmentDate]!),
                   _buildBookingDetailRow('Time:', _latestAppointment[AppointmentsDBHelper.columnAppointmentTime]!),
                   _buildBookingDetailRow('Additional Notes:', _latestAppointment[AppointmentsDBHelper.columnAdditionalNotes] ?? 'None'!), 
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 16),
                    
                    _buildBookingDetailRow('Price : ', '₱${_latestAppointment[AppointmentsDBHelper.columnPrice].toStringAsFixed(2)!}'),
                    SizedBox(height: 20),

                     Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: isTransactionSuccessful
                              ? Colors.green // Change color when transaction is successful
                              : const Color(0xFF28435A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // When button is pressed, update the state to show success
                          setState(() {
                            isTransactionSuccessful = true;
                            isPaid = true;
                          });
                        },
                        child: Text(
                          isTransactionSuccessful ? 'Repair Successful' : 'Confirm Transaction',
                          style: TextStyle(
                            fontSize: isTransactionSuccessful ? 16 : 18, // Adjust font size if needed
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
            )
    )
    )
    );
  }

 Widget _buildBookingDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

}
