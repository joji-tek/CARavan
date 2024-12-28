import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Transaction/transaction_screen.dart';
import 'package:user1_bookingrepair/data/shop.dart';
import 'package:user1_bookingrepair/data/user.dart';
import 'package:user1_bookingrepair/helper/RepairShop/dbheper_booking_repairshop.dart';

class InvoiceScreen extends StatefulWidget {
  final double totalAmount;
  final int bookingId;

  const InvoiceScreen({
    super.key,
    required this.totalAmount,
    required this.bookingId, 
    required bool isTransactionSuccessful, 
    required bool isPaid, 
  });

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String? carModel;
  String? licensePlate;
  String? issueDescription;
  String? address;
  String? additionalNotes;
  bool isTransactionSuccessful = false;
  int? transactionStatus;
  bool isPaid = false;

  @override
  void initState() {
    super.initState();
    _fetchBookingDetails();
  }

  Future<void> _fetchBookingDetails() async {
  final db = await DBHelper.instance.database;
  
  // Fetch the most recent booking (latest booking by highest ID)
  final bookingData = await db.rawQuery(
    'SELECT * FROM Bookings ORDER BY id DESC LIMIT 1'
  );
  
  print("Fetched booking data: $bookingData"); // Debug line
  
  if (bookingData.isNotEmpty) {
    setState(() {
      carModel = bookingData[0]['car_model'] as String?;
      licensePlate = bookingData[0]['license_plate'] as String?;
      issueDescription = bookingData[0]['issue_description']as String?;
      address = '${bookingData[0]['street']}, ${bookingData[0]['barangay']}, ${bookingData[0]['city']}, ${bookingData[0]['province']}, ${bookingData[0]['zip_code']}, ${bookingData[0]['country']}';
      additionalNotes = bookingData[0]['additional_notes']as String?;
    });
  } else {
    print("No booking data found.");
  }
}



  // Save transaction details to the database
  Future<void> _saveTransaction() async {
    final booking = {
      'car_model': carModel,
      'license_plate': licensePlate,
      'issue_description': issueDescription,
      'street': 'Street', // Replace with actual address data
      'barangay': 'Barangay', // Replace with actual data
      'city': 'City', // Replace with actual data
      'province': 'Province', // Replace with actual data
      'zip_code': 'Zip', // Replace with actual data
      'country': 'Country', // Replace with actual data
      'additional_notes': additionalNotes,
      'user_name': users[0].name,
      'user_contact_number': users[0].contactNumber,
      'repair_shop_name': repairShops[0].name,
      'repair_shop_location': repairShops[0].location,
      'repair_shop_number': repairShops[0].number,
      'repair_shop_opening_hours': repairShops[0].openingHours,
      'total_amount': widget.totalAmount,
      'paid' : false,
    };

    await DBHelper.instance.insertBooking(booking);
    print(Text('NOT YET PAID'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Urgent',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )
        ],
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
      body: carModel == null
          ? Center(child: CircularProgressIndicator()) // Show loading while fetching data
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Summary',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildBookingDetailRow('Car Model:', carModel!),
                    _buildBookingDetailRow('License Plate:', licensePlate!),
                    _buildBookingDetailRow('Issue Description:', issueDescription!),
                    _buildBookingDetailRow('Address:', address!),
                    _buildBookingDetailRow('Additional Notes:', additionalNotes!),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 16),
                    // User Details Section
                    Text(
                      'User Details',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    _buildBookingDetailRow('Name:', users[0].name),
                    _buildBookingDetailRow('Contact Number:', users[0].contactNumber),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 16),
                    // Repair Shop Details Section
                    Text(
                      'Repair Shop Details',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    _buildBookingDetailRow('Shop Name:', repairShops[0].name),
                    _buildBookingDetailRow('Location:', repairShops[0].location),
                    _buildBookingDetailRow('Contact Number:', repairShops[0].number),
                    _buildBookingDetailRow('Opening Hours:', repairShops[0].openingHours),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 16),
                    Text(
                      'Total Amount: \₱${widget.totalAmount.toStringAsFixed(2)}', // Append " - Paid" if transactionStatus is 2
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),


                    Text(
                      'Make sure that the service is done before clicking',
                      style: TextStyle(fontSize: 12),
                    ),
                    
                    SizedBox(height: 8,),

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

                          // Save transaction details to the database
                          _saveTransaction();
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
            
                ),
              ),
          ),
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
