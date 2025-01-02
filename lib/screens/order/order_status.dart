import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';

class OrderStatusScreen extends StatelessWidget {
  final String orderId;

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
            Navigator.pop(context);
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
            return Center(
              child: Text(
                'Failed to fetch order details.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final orderData = snapshot.data!.data() as Map<String, dynamic>;
          final products = orderData['products'] as List<dynamic>? ?? [];

          // Determine order-level status
          final statuses = products.map((p) => int.tryParse(p['status'].toString())).toList();
          String orderStatus;
          Color statusColor;

          if (statuses.every((status) => status == 0)) {
            orderStatus = 'Pending';
            statusColor = Colors.orange;
          } else if (statuses.every((status) => status == 1)) {
            orderStatus = 'Approved';
            statusColor = Colors.green;
          } else if (statuses.contains(1) && statuses.any((status) => status == 0)) {
            orderStatus = 'Partial Approval';
            statusColor = Colors.blue;
          } else if (statuses.contains(-1)) {
            orderStatus = 'Partial Rejection';
            statusColor = Colors.red;
          } else {
            orderStatus = 'Unknown';
            statusColor = Colors.grey;
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Status: $orderStatus',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Order ID: $orderId',
                            style: TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Product List
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final String? productId = product['product'] as String?;
                          final int? status = int.tryParse(product['status'].toString());
                          String productStatus;
                          Color productStatusColor;

                          switch (status) {
                            case 1:
                              productStatus = 'Approved';
                              productStatusColor = Colors.green;
                              break;
                            case 0:
                              productStatus = 'Pending';
                              productStatusColor = Colors.orange;
                              break;
                            case -1:
                              productStatus = 'Rejected';
                              productStatusColor = Colors.red;
                              break;
                            default:
                              productStatus = 'Unknown';
                              productStatusColor = Colors.grey;
                          }

                          // Ensure productId is not null
                          if (productId == null) {
                            return _buildProductCard(
                              title: 'Unknown Product',
                              status: productStatus,
                              statusColor: productStatusColor,
                              imageUrl: '',
                            );
                          }

                          // Fetch product details
                          return FutureBuilder<DocumentSnapshot>(
                            future: _firestore.collection('products').doc(productId).get(),
                            builder: (context, productSnapshot) {
                              if (productSnapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }

                              if (productSnapshot.hasError ||
                                  !productSnapshot.hasData ||
                                  !productSnapshot.data!.exists) {
                                return _buildProductCard(
                                  title: 'Unknown Product',
                                  status: productStatus,
                                  statusColor: productStatusColor,
                                  imageUrl: '',
                                );
                              }

                              final productData =
                                  productSnapshot.data!.data() as Map<String, dynamic>;
                              final productName =
                                  productData['title'] ?? 'Unknown Product';
                              final productImage = productData['images'] ?? '';

                              return _buildProductCard(
                                title: productName,
                                status: productStatus,
                                statusColor: productStatusColor,
                                imageUrl: productImage,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Delivery Button at the Bottom
              if (statuses.every((status) => status == 1))
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: CustomColor.primary,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      await _firestore.collection('orders').doc(orderId).delete();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Order marked for delivery and removed.')),
                      );
                    },
                    child: Text(
                      'Mark as Delivered',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String status,
    required Color statusColor,
    required String imageUrl,
  }) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: imageUrl.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'Status: $status',
          style: TextStyle(color: statusColor),
        ),
      ),
    );
  }
}
