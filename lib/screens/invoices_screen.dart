import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of invoices
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Invoice #\$index'),
            subtitle: Text('Amount: \$100.00'), // Replace with actual data
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to invoice details or perform any action
            },
          );
        },
      ),
    );
  }
}