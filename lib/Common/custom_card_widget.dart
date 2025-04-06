import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomCardProduct extends StatefulWidget {
  final ProductModel productModel; // Add this to accept the model
  final bool isPrice;

  CustomCardProduct({
    super.key,
    required this.productModel,
    this.isPrice = false,
  });

  @override
  _CustomCardProductState createState() => _CustomCardProductState();
}

class _CustomCardProductState extends State<CustomCardProduct> {
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    try {
      String userId = FirebaseAuth
          .instance.currentUser!.uid; // Replace with the actual user ID
      String productId = widget.productModel.docId ?? "";

      // Check if the product exists in the user's favorites
      final docSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .collection('likes')
          .doc(productId)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          isFavorite = true;
        });
      }
    } catch (e) {
      print("Error checking favorite status: $e");
    }
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      // Add to Firebase
      try {
        String userId = FirebaseAuth
            .instance.currentUser!.uid; // Replace with the actual user ID
        String productId = widget.productModel.docId!;

        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(userId)
            .collection('likes')
            .doc(productId)
            .set(widget.productModel.toJson());

        print("Added to favorites!");
      } catch (e) {
        print("Error adding to favorites: $e");
      }
    } else {
      // Remove from Firebase
      try {
        String userId = FirebaseAuth
            .instance.currentUser!.uid; // Replace with the actual user ID
        String productId = widget.productModel.docId ?? "";

        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(userId)
            .collection('likes')
            .doc(productId)
            .delete();

        print("Removed from favorites!");
      } catch (e) {
        print("Error removing from favorites: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Container
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(8.0)),
                  image: DecorationImage(
                    image: NetworkImage(widget.productModel.images.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Text Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.productModel.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (widget.isPrice)
                        Text(
                          "${widget.productModel.price} PKR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Favorite Icon
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
