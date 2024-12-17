import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File? _image;

  // Controllers for editing fields
  final TextEditingController FnameController = TextEditingController(text: "Mohammad");
  final TextEditingController LnameController = TextEditingController(text: "Abu Arida");
  final TextEditingController numberController = TextEditingController(text: "123-456-7890");
  final TextEditingController emailController = TextEditingController(text: "demo@example.com");
  final TextEditingController addressController = TextEditingController(text: "123 Demo Street");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addImageWidget(context),
            SizedBox(height: 16),
            FnameWidget(context),
            SizedBox(height: 16),
            LnameWidget(context),
            SizedBox(height: 16),
            contactNumberWidget(context),
            SizedBox(height: 16),
            addressWidget(context),
            SizedBox(height: 16),
            deliveryAddressWidget(context),
            SizedBox(height: 32),
            updateProfileWidget(context),
          ],
        ),
      ),
    );
  }

  Widget addImageWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:
              _image != null ? FileImage(_image!) : AssetImage('assets/images/profile.png') as ImageProvider,
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => _openImageSourceOptions(context),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      ],
    );
  }
  Widget FnameWidget(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.call),
      title: TextField(
        controller: FnameController,
        decoration: InputDecoration(
          labelText: "First Name",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          _editField(
            context,
            "Edit First Name",
            FnameController,
          );
        },
      ),
    );
  }
  Widget LnameWidget(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.call),
      title: TextField(
        controller: LnameController,
        decoration: InputDecoration(
          labelText: "Last Name",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          _editField(
            context,
            "Edit Last Name",
            LnameController,
          );
        },
      ),
    );
  }
  Widget contactNumberWidget(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.call),
      title: TextField(
        controller: numberController,
        decoration: InputDecoration(
          labelText: "Contact Number",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          _editField(
            context,
            "Edit Contact Number",
            numberController,
          );
        },
      ),
    );
  }

  Widget addressWidget(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.email),
      title: TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Email Address",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          _editField(
            context,
            "Edit Email Address",
            emailController,
          );
        },
      ),
    );
  }

  Widget deliveryAddressWidget(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.home),
      title: TextField(
        controller: addressController,
        decoration: InputDecoration(
          labelText: "Delivery Address",
          border: OutlineInputBorder(),
        ),
        readOnly: true,
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {
          _editField(
            context,
            "Edit Delivery Address",
            addressController,
          );
        },
      ),
    );
  }

  Widget updateProfileWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully!")),
        );
      },
      child: Text("Update Profile"),
    );
  }

  Future<void> _openImageSourceOptions(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Icon(Icons.camera_alt, size: 40.0, color: Colors.blue),
                onTap: () {
                  Navigator.of(context).pop();
                  _chooseFromCamera();
                },
              ),
              GestureDetector(
                child: Icon(Icons.photo, size: 40.0, color: Colors.green),
                onTap: () {
                  Navigator.of(context).pop();
                  _chooseFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _chooseFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No file selected")),
      );
    }
  }

  void _chooseFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No capture image")),
      );
    }
  }

  void _editField(BuildContext context, String title, TextEditingController controller) {
    String tempValue = controller.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            onChanged: (value) {
              tempValue = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close without saving
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  controller.text = tempValue; // Save changes
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
