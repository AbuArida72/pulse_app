import 'package:flutter/material.dart';
import 'package:pulse/screens/dashboard/order_status.dart';

class MyOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {'id': '1', 'status': 'In Progress'},
      {'id': '2', 'status': 'Shipped'},
      {'id': '3', 'status': 'Delivered'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long),
            SizedBox(width: 8),
            Text('My Orders'),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Icon(Icons.local_shipping, color: Colors.blue),
                title: Text('Order #${orders[index]['id']}'),
                subtitle: Text('Status: ${orders[index]['status']}'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderStatusScreen(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}