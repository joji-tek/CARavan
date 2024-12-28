import 'package:flutter/material.dart';

class EWalletScreen extends StatelessWidget {
  final double balance = 2500.00; // Example balance
  final List<Map<String, String>> transactions = [
    {
      "date": "2024-12-20",
      "type": "Received",
      "amount": "500.00",
      "description": "Payment from John"
    },
    {
      "date": "2024-12-18",
      "type": "Sent",
      "amount": "150.00",
      "description": "Payment for groceries"
    },
    {
      "date": "2024-12-15",
      "type": "Received",
      "amount": "1200.00",
      "description": "Salary deposit"
    },
    // Add more transactions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Wallet"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Section
            Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "\$${balance.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recent Transactions Section
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        transactions[index]["type"] == "Received"
                            ? Icons.account_balance_wallet
                            : Icons.payment,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                      title: Text(
                        transactions[index]["description"]!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(transactions[index]["date"]!),
                      trailing: Text(
                        "\$${transactions[index]["amount"]!}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: transactions[index]["type"] == "Received"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Action Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add money action
                  },
                  child: Text("Add Money"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Send money action
                  },
                  child: Text("Send Money"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
