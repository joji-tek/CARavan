import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/Repair%20Shop/Payment/epayment_screen.dart';
import 'package:user1_bookingrepair/Repair%20Shop/Payment/invoice_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String issuePrice; 
   // Price from CarRepairBookingScreen

  const PaymentScreen({Key? key, required this.issuePrice, }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final int bookingId = 1;
  String _selectedPaymentMethod = 'Cash';  // Default payment method
  double _taxPercentage = 0.05;  // 5% tax
  double _transactionFee = 50.0;  // Fixed transaction fee
  double _convenienceFee = 30.0;  // Convenience fee

  double get totalAmount {
    double issuePrice = double.parse(widget.issuePrice);
    double tax = issuePrice * _taxPercentage;
    return issuePrice + tax + _transactionFee + _convenienceFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Total Amount to be paid
            Card(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF28435A),),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),  // Optional padding for better spacing
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Total amount display
                    Text(
                      'Total Amount: ₱${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    
                    const SizedBox(height: 20),  // Space between Total Amount and fees
                    
                    // Additional fees display
                    Text(
                      'Tax (5%): ₱${(double.parse(widget.issuePrice) * _taxPercentage).toStringAsFixed(2)}',
                    ),
                    Text('Transaction Fee: ₱$_transactionFee'),
                    Text('Convenience Fee: ₱$_convenienceFee'),
                  ],
                ),
              ),
            ),
          ),

            const SizedBox(height: 20),

            // Payment Method Dropdown
            const Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5,),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              items: ['Cash', 'E-Payment'].map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Payment Method',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Payment Button
            // Inside PaymentScreen
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF28435A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_selectedPaymentMethod == 'Cash') { // Set status to 1 for Cash
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceScreen(
                        totalAmount: totalAmount,
                        bookingId: bookingId,
                        isTransactionSuccessful: true,
                        isPaid: false, // Pass status as argument
                      ),
                    ),
                  );
                } else if (_selectedPaymentMethod == 'E-Payment') {
                  // Simulate redirect to payment gateway or E-Payment handling logic
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("E-Payment"),
                        content: const Text(
                          "Redirecting to E-Payment gateway for processing...",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () { // Set status to 2 for E-Payment
                              Navigator.pop(context); // Close dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EpaymentScreen(
                                    totalAmount: totalAmount, 
                                    isPaid: true,// Pass status to E-payment screen
                                  ),
                                ),
                              );
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },

              child: const Text('Proceed to Payment'),
            )


          ],
        ),
      ),
    );
  }
}


