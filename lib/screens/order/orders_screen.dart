import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/screens/order/order_status.dart';

class MyOrderScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Please log in to view your orders.'),
        ),
      );
    }

    final String userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.list_alt),
            SizedBox(width: 8),
            Text('My Orders'),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('orders')
                    .where('user_id', isEqualTo: userId) // Query orders for the current user
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No orders found.'));
                  }

                  // Include all orders but handle statuses in display logic
                  final filteredOrders = snapshot.data!.docs.toList();

                  return ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      final date = (order['date'] as Timestamp).toDate();
                      final products = order['products'] as List<dynamic>? ?? [];
                      final statuses = products.map((p) {
                        final status = p['status'];
                        return int.tryParse(status.toString());
                      }).toList();

                      // Determine the overall status of the order
                      String statusText;
                      Color statusColor;

                      if (statuses.isEmpty) {
                        statusText = 'No Products';
                        statusColor = Colors.grey;
                      } else if (statuses.every((status) => status == -1)) {
                        statusText = 'Rejected';
                        statusColor = Colors.red;
                      } else if (statuses.every((status) => status == 0)) {
                        statusText = 'Pending';
                        statusColor = Colors.yellow;
                      } else if (statuses.contains(1) && statuses.any((status) => status == 0)) {
                        statusText = 'Partial Approval';
                        statusColor = Colors.blue;
                      } else if (statuses.every((status) => status == 1)) {
                        statusText = 'Approved';
                        statusColor = Colors.green;
                      } else if (statuses.contains(-1)) {
                        statusText = 'Partial Rejection';
                        statusColor = Colors.orange;
                      } else {
                        statusText = 'Unknown';
                        statusColor = Colors.grey;
                      }

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Date: ${date.toLocal()}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Status: $statusText',
                              style: TextStyle(fontSize: 14, color: statusColor),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: CustomColor.primary,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              onPressed: () {
                                // Navigate to Order Status Screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderStatusScreen(orderId: order.id),
                                  ),
                                );
                              },
                              child: Text('View Details'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
