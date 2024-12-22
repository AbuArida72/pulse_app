import 'package:flutter/material.dart';
import 'package:pulse/screens/contact_us.dart';
import 'package:pulse/screens/dashboard/cart.dart';
import 'package:pulse/screens/invoices_screen.dart';
import 'package:pulse/screens/my_order_screen.dart';
import 'package:pulse/screens/payment_method/payment-method.dart';
import 'package:pulse/screens/profile_screen.dart';
import 'package:pulse/screens/search.dart';
import 'package:pulse/screens/welcome_screen.dart';

class DashboardScreen extends StatelessWidget {
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
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
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
              leading: Icon(Icons.receipt_long, color: Colors.red),
              title: Text('Invoices'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicesScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.red),
              title: Text('Wallet'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.red),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
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
                    DrugGridView(),
                    SizedBox(height: 20),
                    SectionTitle(title: 'Categories'),
                    SizedBox(height: 10),
                    CategoryListView(),
                    SizedBox(height: 20),
                    SectionTitle(title: 'Top Picks for You'),
                    SizedBox(height: 10),
                    DrugHorizontalListView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
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
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medical_services, size: 40, color: Colors.red),
                  SizedBox(height: 10),
                  Text('Drug ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.red),
            ),
            child: Center(
              child: Text(
                'Category ${index + 1}',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrugHorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
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
                      Icon(Icons.medical_services, size: 40, color: Colors.red),
                      SizedBox(height: 10),
                      Text('Top Pick ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
