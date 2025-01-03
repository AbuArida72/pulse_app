import 'package:pulse/helpers/app_export.dart';
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

          if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.exists) {
            return Center(
              child: Text(
                'Failed to fetch order details.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final orderData = snapshot.data!.data() as Map<String, dynamic>;
          final products = orderData['products'] as List<dynamic>? ?? [];

          // Fetch product details
          final productIds =
              products.map((p) => p['product'] as String).toList();
          return FutureBuilder<List<DocumentSnapshot>>(
            future: _firestore
                .collection('products')
                .where(FieldPath.documentId, whereIn: productIds)
                .get()
                .then((query) => query.docs),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (productSnapshot.hasError || !productSnapshot.hasData) {
                return Center(
                  child: Text(
                    'Failed to fetch product details.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }

              final productDataMap = {
                for (var doc in productSnapshot.data!)
                  doc.id: doc.data() as Map<String, dynamic>
              };

              // Extract statuses from products
              final statuses = products.map((p) {
                final status = int.tryParse(p['status']?.toString() ?? '-2');
                return status;
              }).toList();

              // Determine status conditions
              final allRejected = statuses.every((status) => status == -1);
              final allApproved = statuses.every((status) => status == 1);
              final allPending = statuses.every((status) => status == 0);
              final hasRejected = statuses.contains(-1);
              final hasApproved = statuses.contains(1);
              final hasPending = statuses.contains(0);

              // Determine the order status
              String orderStatus;
              Color statusColor;

              if (allRejected) {
                orderStatus = 'Rejected';
                statusColor = Colors.red;
              } else if (allApproved) {
                orderStatus = 'Approved';
                statusColor = Colors.green;
              } else if (allPending) {
                orderStatus = 'Pending';
                statusColor = Colors.orange;
              } else if (hasRejected && !hasApproved) {
                orderStatus = 'Partial Rejection';
                statusColor = Colors.redAccent;
              } else if (hasApproved && hasPending) {
                orderStatus = 'Partial Approval';
                statusColor = Colors.blue;
              } else if (hasRejected && hasApproved && !hasPending) {
                orderStatus = 'Closed';
                statusColor = Colors.blueGrey;
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white70),
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
                              final String productId = product['product'];
                              final int? status =
                                  int.tryParse(product['status'].toString());
                              final productDetails = productDataMap[productId];
                              final productName =
                                  productDetails?['title'] ?? 'Unknown Product';
                              final productImage =
                                  productDetails?['images'] ?? '';

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

                              return _buildProductCard(
                                title: productName,
                                status: productStatus,
                                statusColor: productStatusColor,
                                imageUrl:
                                    productImage, // This is likely an expired or invalid URL
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons at the Bottom
                  if (allRejected ||
                      (hasRejected && hasApproved && !hasPending))
                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              allRejected ? Colors.red : Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          await _firestore
                              .collection('orders')
                              .doc(orderId)
                              .delete();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(allRejected
                                  ? 'Order deleted.'
                                  : 'Order closed and deleted.'),
                            ),
                          );
                        },
                        child: Text(
                          allRejected ? 'Close Order' : 'Close Order',
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
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image,
                        size: 50, color: Colors.grey);
                  },
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
