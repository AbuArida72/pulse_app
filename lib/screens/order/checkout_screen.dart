import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/screens/order/orders_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final String userId;

  CheckoutScreen({required this.userId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder(BuildContext context, List<Map<String, dynamic>> cartItems) async {
    try {
      final orderRef = _firestore.collection('orders').doc();
      final DateTime now = DateTime.now();

      // Calculate total price
      double totalPrice = cartItems.fold(
        0,
        (sum, item) =>
            sum + ((double.tryParse(item['price'].toString()) ?? 0.0) * (item['quantity'] ?? 0)),
      );

      // Create order in Firebase
      await orderRef.set({
        'userId': userId,
        'products': cartItems,
        'totalPrice': totalPrice,
        'status': 'Pending',
        'date': now,
        'createdAt': now,
        'updatedAt': now,
      });

      // Clear cart
      await _firestore.collection('carts').doc(userId).update({'items': []});

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Order Placed'),
          content: Text('Your order has been successfully placed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyOrderScreen()),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('carts').doc(userId).snapshots(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('An error occurred. Please try again.'));
          }

          // Check if cart data exists
          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Center(child: Text('Your cart is empty.'));
          }

          final cartData = snapshot.data!.data() as Map<String, dynamic>?;
          final List<Map<String, dynamic>> cartItems =
              List<Map<String, dynamic>>.from(cartData?['items'] ?? []);

          // Check if cart is empty
          if (cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }

          // Calculate total price
          double totalPrice = cartItems.fold(
            0,
            (sum, item) =>
                sum + ((double.tryParse(item['price'].toString()) ?? 0.0) * (item['quantity'] ?? 0)),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
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
                      Text('Delivery Address:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('123 Main Street, Springfield', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Contact Number:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('+123 456 7890', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
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
                      Text('Order Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ...cartItems.map<Widget>((item) {
                        final double price = double.tryParse(item['price'].toString()) ?? 0.0;
                        final int quantity = item['quantity'] ?? 0;

                        return ListTile(
                          title: Text(item['name'] ?? 'Unknown Product'),
                          trailing: Text('\$${(price * quantity).toStringAsFixed(2)}'),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: CustomColor.primary,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => placeOrder(context, cartItems),
                      child: Text('Place Order'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
