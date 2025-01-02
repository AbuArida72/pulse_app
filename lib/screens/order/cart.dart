import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/screens/order/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('User not logged in. Please log in to access your cart.'),
        ),
      );
    }

    final String userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 8),
            Text('Cart'),
          ],
        ),
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

          // Check if data exists
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Your cart is empty.'));
          }

          final cartData = snapshot.data!.data() as Map<String, dynamic>?;

          // Check if 'items' exists in the cart data
          if (cartData == null || cartData['items'] == null) {
            return Center(child: Text('Your cart is empty.'));
          }

          // Extract cart items
          final List<dynamic> cartItems = cartData['items'] ?? [];

          // Check if there are items in the cart
          if (cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                      Text('Your Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ...cartItems.map<Widget>((item) {
                        final double price = double.tryParse(item['price'].toString()) ?? 0.0;
                        final int quantity = item['quantity'] ?? 0;

                        return ListTile(
                          title: Text(item['name']),
                          subtitle: Text('Qty: $quantity'),
                          trailing: Text(
                              '\$${(price * quantity).toStringAsFixed(2)}'),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: CustomColor.primary,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(user_id: userId),
                          ),
                        );
                      },
                      child: Text('Checkout'),
                    ),
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
