import 'package:flutter/material.dart';
import 'package:pulse/screens/payment_method/add_card.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? savedCard; // Holds the saved card details if any

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCardScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: savedCard == null
            ? Text('No saved card')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Saved Card:'),
                  SizedBox(height: 10),
                  Text(savedCard!,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}