import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Contact Us', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('Phone:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('+962 7 9 921 2538', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('Email:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('pulsegp2@gmail.com', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}