import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrderScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> placeOrder(BuildContext context) async {
    try {
      // Fetch all items from the cart collection
      QuerySnapshot cartSnapshot = await _firestore.collection('cart').get();

      if (cartSnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your cart is empty')),
        );
        return;
      }

      // Create an order for each cart item
      for (var cartDoc in cartSnapshot.docs) {
        final cartItem = cartDoc.data() as Map<String, dynamic>;

        await _firestore.collection('orders').add({
          'productId': cartItem['productId'],
          'title': cartItem['title'],
          'price': cartItem['price'],
          'quantity': cartItem['quantity'],
          'image': cartItem['image'],
          'status': 'In Progress', // Default status
          'createdAt': Timestamp.now(),
        });
      }

      // Clear the cart after placing the order
      for (var cartDoc in cartSnapshot.docs) {
        await _firestore.collection('cart').doc(cartDoc.id).delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
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
        title: Text('My Cart'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }

          final cartItems = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index].data() as Map<String, dynamic>;

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Image.network(
                            cartItem['image'] ?? '',
                            width: 50,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported),
                          ),
                          title: Text(cartItem['title'] ?? 'No Title'),
                          subtitle: Text('Price: \$${cartItem['price'] ?? '0.00'}'),
                          trailing: Text('Qty: ${cartItem['quantity'] ?? 1}'),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => placeOrder(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Place Order'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
