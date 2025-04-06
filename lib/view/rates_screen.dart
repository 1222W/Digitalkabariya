import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Utils/app_colors.dart';
import 'package:digital_kabaria_app/widgets/rates_card_widget.dart';
import 'package:flutter/material.dart';

class RatesScreen extends StatefulWidget {
  const RatesScreen({super.key});

  @override
  State<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  final CollectionReference ratesCollection =
      FirebaseFirestore.instance.collection('rates');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 174, 152, 106),
        title:
            const Text('Rates', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ratesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading data"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No rates available"));
          }

          // Get the documents from snapshot
          final rates = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(18.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 18.0,
            ),
            itemCount: rates.length,
            itemBuilder: (context, index) {
              // Retrieve data from each document
              final rateData = rates[index].data() as Map<String, dynamic>;
              final title = rateData['title'] ?? 'No title';
              final price = rateData['price'] ?? 'No price';

              return RatesCardWidget(
                title: title,
                price: price.toString(),
              );
            },
          );
        },
      ),
    );
  }
}
