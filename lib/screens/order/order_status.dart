import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';

class OrderStatusScreen extends StatelessWidget {
  final String orderId; // Receive the order ID from navigation arguments

  OrderStatusScreen({required this.orderId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        centerTitle: true,
        backgroundColor: CustomColor.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('orders').doc(orderId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Failed to fetch order details.'));
          }

          final orderData = snapshot.data!.data() as Map<String, dynamic>;

          // Handle status
          final String status = orderData['status'] ?? 'Unknown';
          String message;
          IconData statusIcon;
          LinearGradient gradient;

          if (status == 'In Progress') {
            message = "The order is being serviced now.";
            statusIcon = Icons.local_shipping; // Icon for "In Progress" status
            gradient = LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
          } else if (status == 'Pending') {
            message = "The order is still pending approval.";
            statusIcon = Icons.hourglass_empty;
            gradient = LinearGradient(
              colors: [CustomColor.primary, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
          } else {
            message = "Unknown order status.";
            statusIcon = Icons.error_outline;
            gradient = LinearGradient(
              colors: [Colors.grey, Colors.grey.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );
          }

          // Extract the products array and calculate total price
          List<dynamic> products = orderData['products'] ?? [];
          double totalPrice = 0.0;

          // Calculate the total price of all items
          for (var item in products) {
            double price = double.tryParse(item['price'].toString()) ?? 0.0;
            int quantity = item['quantity'] ?? 0;
            totalPrice += price * quantity;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: gradient, // Set the gradient based on status
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        statusIcon,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Order ID: $orderId',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        message,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Items List Widget
                Expanded(child: OrderItemsList(products: products)),
                // Display the total price
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, color: CustomColor.primary),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: CustomColor.primary,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to the orders screen
                    },
                    child: Text('Back to Orders'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderItemsList extends StatelessWidget {
  final List<dynamic> products;

  const OrderItemsList({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final productName = product['name'] ?? 'Unknown Product';
        final price = double.tryParse(product['price'].toString()) ?? 0.0;
        final quantity = product['quantity'] ?? 0;

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Text(productName, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Qty: $quantity'),
            trailing: Text('\$${(price * quantity).toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}
