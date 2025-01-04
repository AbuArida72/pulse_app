import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';

class DrugDetailsPage extends StatefulWidget {
  final String productId; 

  DrugDetailsPage({required this.productId});

  @override
  _DrugDetailsPageState createState() => _DrugDetailsPageState();
}

class _DrugDetailsPageState extends State<DrugDetailsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int quantity = 1; // Default quantity

  Future<void> addToCart(BuildContext context, String productId, Map<String, dynamic> productData, String userId) async {
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
        items[existingItemIndex]['quantity'] += quantity;
      } else {
        items.add({
          'productId': productId, // Use document ID as productId
          'name': productData['title'],
          'price': double.parse(productData['price'].toString()),
          'quantity': quantity,
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
            'price': double.parse(productData['price'].toString()),
            'quantity': quantity,
            'image': productData['images'],
          },
        ],
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
    }

    // Show popup dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item Added'),
          content: Text('${productData['title']} has been added to your cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add to cart: $e')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Drug Details'),
          backgroundColor: CustomColor.primary,
        ),
        body: Center(
          child: Text('You must be logged in to view and add items to your cart.'),
        ),
      );
    }

    final String userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Drug Details'),
        backgroundColor: CustomColor.primary,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('products').doc(widget.productId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Drug details not found.'));
          }

          final productData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        productData['images'],
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported, size: 200, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 2),
                  Text(
                    productData['title'] ?? 'No Title',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: CustomColor.primary),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Text(
                    productData['description'] ?? 'No Description',
                    style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[700]),
                  ),
                  SizedBox(height: Dimensions.heightSize * 2),
                  Text(
                    '\$${productData['price'] ?? '0.00'}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: CustomColor.primary),
                  ),
                  SizedBox(height: Dimensions.heightSize * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.heightSize * 3),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => addToCart(context, widget.productId, productData, userId),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: CustomColor.primary,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
