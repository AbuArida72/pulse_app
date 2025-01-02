import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/screens/drug.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _searchQuery = ""; // Store the current search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for a Drug'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter drug name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase(); // Update search query
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('products')
                    .where('status', isEqualTo: "0") // Only fetch drugs with status "0"
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Filter drugs based on search query
                  final List<QueryDocumentSnapshot> filteredDrugs = snapshot.data!.docs.where((doc) {
                    final drugData = doc.data() as Map<String, dynamic>;
                    final String drugTitle = (drugData['title'] ?? "").toLowerCase();
                    return drugTitle.contains(_searchQuery);
                  }).toList();

                  if (filteredDrugs.isEmpty) {
                    return Center(child: Text('No drugs found.'));
                  }

                  return ListView.builder(
                    itemCount: filteredDrugs.length,
                    itemBuilder: (context, index) {
                      final drug = filteredDrugs[index].data() as Map<String, dynamic>;
                      final String drugId = filteredDrugs[index].id;

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Image.network(
                            drug['images'] ?? '',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image_not_supported, size: 50),
                          ),
                          title: Text(drug['title'] ?? 'Unknown Drug'),
                          subtitle: Text(drug['description'] ?? 'No Description'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            // Navigate to drug details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrugDetailsPage(productId: drugId),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
