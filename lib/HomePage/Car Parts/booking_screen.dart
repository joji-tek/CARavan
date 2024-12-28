import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final String partName;
  final int partPrice;
  final String partDescription;
  final String imageUrl; // New parameter for the image URL

  const BookingScreen({
    super.key,
    required this.partName,
    required this.partPrice,
    required this.partDescription,
    required this.imageUrl, // Initialize the image URL
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Payment Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF28435A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Part Details Section
              const Text(
                'Part Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4,
                child: Column(
                  children: [
                    // Image Section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network( // Change from Image.network to Image.asset for local assets
                        imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    ListTile(
                      title: Text(partName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: Php $partPrice'),
                          const SizedBox(height: 4),
                          Text(partDescription),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Payment Method Section
              const SizedBox(height: 16),
              const Text(
                'Payment Method:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  ListTile(
                    leading: Radio(value: 1, groupValue: 1, onChanged: (value) {}),
                    title: const Text('Credit/Debit Card'),
                  ),
                  ListTile(
                    leading: Radio(value: 2, groupValue: 1, onChanged: (value) {}),
                    title: const Text('Bank Transfer'),
                  ),
                  ListTile(
                    leading: Radio(value: 3, groupValue: 1, onChanged: (value) {}),
                    title: const Text('Digital Wallet'),
                  ),
                  ListTile(
                    leading: Radio(value: 4, groupValue: 1, onChanged: (value) {}),
                    title: const Text('Cash on Delivery'),
                  ),
                ],
              ),

              // Action Buttons
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add booking confirmation logic
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Purchase Confirmed'),
                          content: Text('You have successfully bought the $partName for Php $partPrice.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context); // Close both dialogs
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('CONFIRM'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('CANCEL'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
