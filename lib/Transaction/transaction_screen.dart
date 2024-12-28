import 'package:flutter/material.dart';
import 'package:user1_bookingrepair/NavBar/custom_nav_bar.dart';
import 'package:user1_bookingrepair/Transaction/transaction_details_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

// Dummy transaction data class
class Transaction {
  final String productName;
  final double amount;
  final String transactionType; // "Bought" or "Rented"
  final int loyaltyPoints;
  final String transactionDate;

  Transaction({
    required this.productName,
    required this.amount,
    required this.transactionType,
    required this.loyaltyPoints,
    required this.transactionDate,
  });
}

// Dummy transaction list
final List<Transaction> transactions = [
  Transaction(
      productName: 'Brake Pads',
      amount: 120.00,
      transactionType: 'Bought',
      loyaltyPoints: 150,
      transactionDate: '2024-12-20'),
  Transaction(
      productName: 'Toyota Vios',
      amount: 1500.00,
      transactionType: 'Rented',
      loyaltyPoints: 100,
      transactionDate: '2024-12-19'),
  Transaction(
      productName: 'Tire Replacement',
      amount: 200.00,
      transactionType: 'Bought',
      loyaltyPoints: 250,
      transactionDate: '2024-12-18'),
  Transaction(
      productName: 'Car Battery',
      amount: 150.00,
      transactionType: 'Bought',
      loyaltyPoints: 200,
      transactionDate: '2024-12-17'),
];

class _TransactionScreenState extends State<TransactionScreen> {
  int _currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Transactions"),
        centerTitle: true,
        backgroundColor: const Color(0xFF28435A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        // Your screen content here
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  transaction.productName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
                    Text('Points Earned: ${transaction.loyaltyPoints}'),
                    Text('Date: ${transaction.transactionDate}'),
                  ],
                ),
                trailing: Text(
                  transaction.transactionType,
                  style: TextStyle(
                    color: transaction.transactionType == "Bought"
                        ? Colors.green
                        : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionDetailsScreen(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        activeIndex: _currentIndex,
        onTap: (v) {
          setState(() {
            _currentIndex = v; // Update the index on tap
          });
        },
      ),
    );
  }
}
