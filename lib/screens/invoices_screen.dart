import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InvoicesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Invoices'),
        ),
        body: Center(
          child: Text('You need to log in to view your invoices.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('orders')
            .where('user_id', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No invoices found.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;
              final date = order['date']?.toDate() ?? DateTime.now();
              final products = order['products'] as List<dynamic>? ?? [];
              final orderStatus = order['status'] ?? 'Unknown';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text('Invoice #${orders[index].id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${date.toLocal()}'),
                      Text('Products: ${products.length} items'),
                      Text('Status: $orderStatus'),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to detailed invoice screen or show more details
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invoice Details'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Date: ${date.toLocal()}'),
                            Text('Products:'),
                            ...products.map((product) {
                              final productData = product as Map<String, dynamic>;
                              return Text(
                                  '- ${productData['product']}, Qty: ${productData['quantity']}');
                            }).toList(),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
