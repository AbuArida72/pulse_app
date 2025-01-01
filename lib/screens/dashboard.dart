import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/screens/contact_us.dart';
import 'package:pulse/screens/drug.dart';
import 'package:pulse/screens/order/cart.dart';
import 'package:pulse/screens/invoices_screen.dart';
import 'package:pulse/screens/order/orders_screen.dart';
import 'package:pulse/screens/payment_method/payment-method.dart';
import 'package:pulse/screens/profile_screen.dart';
import 'package:pulse/screens/search.dart';
import 'package:pulse/screens/welcome_screen.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, color: Colors.black),
            SizedBox(width: 8),
            Text('Dashboard'),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
            },
          ),
        ],
        backgroundColor: CustomColor.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: CustomColor.primary,
              ),
              child: Text(
                'PULSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.receipt_long, color: CustomColor.primary),
              title: Text('Invoices'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicesScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet, color: CustomColor.primary),
              title: Text('Wallet'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: CustomColor.primary),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: CustomColor.primary),
              title: Text('Sign Out'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, User!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'Featured Drugs'),
                    SizedBox(height: 10),
                    DrugGridView(firestore: _firestore),
                    SizedBox(height: 20),
                    SectionTitle(title: 'Categories'),
                    SizedBox(height: 10),
                    CategoryListView(firestore: _firestore),
                    SizedBox(height: 20),
                    SectionTitle(title: 'Top Picks for You'),
                    SizedBox(height: 10),
                    DrugHorizontalListView(firestore: _firestore),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomColor.primary,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderScreen()));
              break;
          }
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class DrugGridView extends StatelessWidget {
  final FirebaseFirestore firestore;

  DrugGridView({required this.firestore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index].data() as Map<String, dynamic>;
            final productId = products[index].id; // Get the document ID
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrugDetailsPage(productId: productId),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          product['images'] ?? '',
                          height: 80,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product['title'] ?? 'No Title',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$${product['price'] ?? '0.00'}'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class CategoryListView extends StatelessWidget {
  final FirebaseFirestore firestore;

  CategoryListView({required this.firestore});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index].data() as Map<String, dynamic>;
              return Container(
                width: 120,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: CustomColor.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: CustomColor.primary),
                ),
                child: Center(
                  child: Text(
                    category['name'] ?? 'No Name',
                    style: TextStyle(color: CustomColor.primary, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DrugHorizontalListView extends StatelessWidget {
  final FirebaseFirestore firestore;

  DrugHorizontalListView({required this.firestore});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              final productId = products[index].id; // Get the document ID
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DrugDetailsPage(productId: productId),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 150,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              product['images'] ?? '',
                              height: 60,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported),
                            ),
                            SizedBox(height: 10),
                            Text(
                              product['title'] ?? 'No Title',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$${product['price'] ?? '0.00'}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
