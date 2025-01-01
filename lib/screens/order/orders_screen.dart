import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/screens/order/order_status.dart';

class MyOrderScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final String userId = "user123"; // Replace with dynamic user ID from authentication

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min, // Ensures proper alignment
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
                    .where('userId', isEqualTo: userId) // Fetch orders for the logged-in user
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No orders found.'));
                  }

                  final orders = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      final date = (order['date'] as Timestamp).toDate();
                      final status = order['status'] ?? '';

                      // Determine status text and color based on string values
                      Color statusColor;
                      String statusText;
                      switch (status) {
                        case 'In Progress':
                          statusColor = Colors.green;
                          statusText = 'The order is being serviced now.';
                          break;
                        case 'Pending':
                          statusColor = Colors.yellow;
                          statusText = 'The order is still pending approval.';
                          break;
                        case 'Approved':
                          statusColor = Colors.blue;
                          statusText = 'The order has been approved.';
                          break;
                        default:
                          statusColor = Colors.grey;
                          statusText = 'Unknown status.';
                          break;
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
