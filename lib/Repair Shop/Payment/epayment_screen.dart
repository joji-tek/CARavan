import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:user1_bookingrepair/Repair%20Shop/Payment/invoice_epayment.dart';
import 'package:user1_bookingrepair/Repair%20Shop/Payment/invoice_screen.dart'; // Import the file picker package

class EpaymentScreen extends StatefulWidget {
  final double totalAmount;

  const EpaymentScreen({Key? key, required this.totalAmount, required bool isPaid,}) : super(key: key);

  @override
  _EpaymentScreenState createState() => _EpaymentScreenState();
}

class _EpaymentScreenState extends State<EpaymentScreen> {
  String? selectedBank; // For tracking selected bank in Bank Transfer
  final List<String> banks = ['LandBank', 'BDO']; // Example banks
  String? filePath;
  final bool isTransactionSuccesful = true;
  final int bookingId = 0;
  final bool isPaid = true;

  // Function to open the file picker and allow user to select a file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Allow only image files
    );

    if (result != null) {
      setState(() {
        filePath = result.files.single.path; // Store the file path
      });
    } else {
      // User canceled the picker
      setState(() {
        filePath = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EPayment'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Gcash'),
              Tab(text: 'Bank Transfer'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Gcash Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Text(
                      'Pay using Gcash',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Total Amount: ₱${widget.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    // CARavan Gcash Info Container
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'CARavan Gcash Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account Name:'),
                                Text('CARavan Corp'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account Number:'),
                                Text('09123456789'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Code:'),
                                Text('12345'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // User Gcash Input Details Container
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Gcash Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Your Account Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Your Account Number',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Amount Sent',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Transaction Details Container
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Reference Number',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _pickFile, // Open file picker
                                    icon: const Icon(Icons.upload),
                                    label: const Text('Upload Receipt Screenshot'),
                                  ),
                                ),
                              ],
                            ),
                            if (filePath != null) ...[
                              const SizedBox(height: 10),
                              Text(
                                'Selected File: ${filePath!.split('/').last}', // Display file name
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Proceed Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InvoiceEpayment(
                              totalAmount: widget.totalAmount, 
                              bookingId: bookingId, 
                              isTransactionSuccessful: true, 
                              isPaid: true,
                            ),
                          ),
                        );
                      },
                      child: const Text('Proceed with Gcash'),
                    ),
                  ],
                ),
              ),
            ),
            // Bank Transfer Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Total Amount
                    Text(
                      'Pay using Bank Transfer',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Total Amount: ₱${widget.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    // Bank Selection Dropdown
                    const Text(
                      'Select Your Bank:',
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedBank,
                      items: banks.map((bank) {
                        return DropdownMenuItem<String>(
                          value: bank,
                          child: Text(bank),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBank = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Bank',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bank Transfer Info Section (Only show after bank selection)
                    if (selectedBank != null) ...[
                      Text(
                        '$selectedBank Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      // Bank Info Card
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Account Name:'),
                                  Text('CARavan'),  // Replace with actual account name
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Account Number:'),
                                  Text('1234567890'),  // Replace with actual account number
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Bank Branch:'),
                                  Text('Main Branch'),  // Replace with actual branch name
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // User Bank Input Details
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Bank Transfer Details',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Your Account Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Your Account Number',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Amount Sent',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Transaction Details Section (Similar to the Gcash section)
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transaction Details',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Reference Number',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: _pickFile, // Open file picker for receipt screenshot
                                      icon: const Icon(Icons.upload),
                                      label: const Text('Upload Receipt Screenshot'),
                                    ),
                                  ),
                                ],
                              ),
                              if (filePath != null) ...[
                                const SizedBox(height: 10),
                                Text(
                                  'Selected File: ${filePath!.split('/').last}', // Display file name
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Proceed Button for Bank Transfer
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvoiceEpayment(
                                totalAmount: widget.totalAmount,
                                bookingId: bookingId, 
                                isTransactionSuccessful: true,
                                isPaid: true,
                              ),
                            ),
                          );
                          print('Paid');
                        },
                        child: const Text('Proceed with Bank Transfer'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
