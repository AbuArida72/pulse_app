import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/screens/order/orders_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final String user_id;

  CheckoutScreen({required this.user_id});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder(BuildContext context, List<Map<String, dynamic>> cartItems) async {
    try {
      final List<Map<String, dynamic>> products = [];
      final DateTime now = DateTime.now();

      // Fetch the product status for each item in the cart
      for (var item in cartItems) {
        final String productId = item['productId'] as String;
        final int cartQuantity = item['quantity'] as int;

        // Fetch the product document from Firestore
        final productDoc = await _firestore.collection('products').doc(productId).get();
        if (productDoc.exists) {
          products.add({
            'product': productId,
            'quantity': cartQuantity,
            'status': 0, // Default status
          });
        }
      }

      // Save the order with the products array
      final orderRef = _firestore.collection('orders').doc();
      await orderRef.set({
        'date': now,
        'products': products,
        'status': [],
        'updatedDtm': now,
        'user_id': user_id,
      });

      // Clear the user's cart
      await _firestore.collection('carts').doc(user_id).update({'items': []});

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Order Placed'),
          content: Text('Your order has been successfully placed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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

  Future<Map<String, dynamic>?> fetchUserData() async {
    final userDoc = await _firestore.collection('users').doc(user_id).get();
    if (userDoc.exists) {
      return userDoc.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserData(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError || userSnapshot.data == null) {
            return Center(child: Text('Failed to load user details.'));
          }

          final userData = userSnapshot.data!;
          final deliveryAddress = userData['street'] ?? 'Unknown Address';
          final contactNumber = userData['phone'] ?? 'Unknown Number';

          return StreamBuilder<DocumentSnapshot>(
            stream: _firestore.collection('carts').doc(user_id).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData || snapshot.data?.data() == null) {
                return Center(child: Text('Your cart is empty.'));
              }

              final cartData = snapshot.data!.data() as Map<String, dynamic>?;
              final List<Map<String, dynamic>> cartItems =
                  List<Map<String, dynamic>>.from(cartData?['items'] ?? []);

              if (cartItems.isEmpty) {
                return Center(child: Text('Your cart is empty.'));
              }

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
                          Text('Delivery Address:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(deliveryAddress, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Text('Contact Number:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(contactNumber, style: TextStyle(fontSize: 16)),
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
                          Text('Order Review',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          ...cartItems.map<Widget>((item) {
                            final double price = double.tryParse(item['price'].toString()) ?? 0.0;
                            final int quantity = item['quantity'] ?? 0;

                            return ListTile(
                              title: Text(item['name']),
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
          );
        },
      ),
    );
  }
}
