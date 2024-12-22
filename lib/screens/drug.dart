import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';

class DrugDetailsPage extends StatelessWidget {
  final String productId; // ID of the drug document in Firestore

  DrugDetailsPage({required this.productId});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(BuildContext context, Map<String, dynamic> productData) async {
    try {
      // Add drug details to the cart collection
      await _firestore.collection('cart').add({
        'productId': productId,
        'title': productData['title'],
        'price': productData['price'],
        'quantity': 1, // Default quantity
        'image': productData['images'],
      });

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('${productData['title']} has been added to your cart.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drug Details'),
        backgroundColor: CustomColor.primary,
        iconTheme: IconThemeData(color: Colors.white), // White back arrow
        titleTextStyle: TextStyle(
          color: Colors.white, // White title
          fontSize: Dimensions.largeTextSize,
          fontWeight: FontWeight.bold,
        ),
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
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 200),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: CustomColor.primary),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => addToCart(context, productData),
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
