import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';

class DrugDetailsPage extends StatelessWidget {
  final String productId; // Document ID of the product in Firestore

  DrugDetailsPage({required this.productId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(BuildContext context, Map<String, dynamic> productData, String userId) async {
    try {
      final cartRef = _firestore.collection('carts').doc(userId);

      // Fetch the current cart data
      final cartDoc = await cartRef.get();

      if (cartDoc.exists) {
        final cartData = cartDoc.data() as Map<String, dynamic>;
        final items = List<Map<String, dynamic>>.from(cartData['items'] ?? []);

        // Check if the product already exists in the cart
        final existingItemIndex = items.indexWhere((item) => item['productId'] == productId);

        if (existingItemIndex != -1) {
          items[existingItemIndex]['quantity'] += 1;
        } else {
          items.add({
            'productId': productId, // Use document ID as productId
            'name': productData['title'],
            'price': double.parse(productData['price']),
            'quantity': 1,
            'image': productData['images'],
          });
        }

        // Update the cart in Firebase
        await cartRef.update({'items': items, 'updatedAt': DateTime.now()});
      } else {
        // Create a new cart document
        await cartRef.set({
          'userId': userId,
          'items': [
            {
              'productId': productId, // Use document ID as productId
              'name': productData['title'],
              'price': double.parse(productData['price']),
              'quantity': 1,
              'image': productData['images'],
            },
          ],
          'createdAt': DateTime.now(),
          'updatedAt': DateTime.now(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${productData['title']} has been added to your cart.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userId = "user123"; // Replace with dynamic user ID from authentication

    return Scaffold(
      appBar: AppBar(
        title: Text('Drug Details'),
        backgroundColor: CustomColor.primary,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('products').doc(productId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Drug details not found.'));
          }

          final productData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    productData['images'] ?? '',
                    height: 200,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image_not_supported, size: 200),
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 2),
                Text(
                  productData['title'] ?? 'No Title',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Dimensions.heightSize),
                Text(
                  productData['description'] ?? 'No Description',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: Dimensions.heightSize * 2),
                Text(
                  '\$${productData['price'] ?? '0.00'}',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.primary),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => addToCart(context, productData, userId),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: CustomColor.primary,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: Center(child: Text('Add to Cart')),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
