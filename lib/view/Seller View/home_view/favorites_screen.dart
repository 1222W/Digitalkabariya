import 'package:digital_kabaria_app/Common/custom_card_widget.dart';
import 'package:digital_kabaria_app/controllers/favorites_controller.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/widgets/custom_favorite_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace "your_user_id" with actual user ID from authentication
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch favorites when the screen is loaded
    favoritesController.fetchFavorites(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (favoritesController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (favoritesController.favorites.isEmpty) {
          return Center(
            child: Text(
              "No Favorites Found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          itemCount: favoritesController.favorites.length,
          itemBuilder: (context, index) {
            var product = favoritesController.favorites[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CustomFavoriteCard(
                productModel: product,
                onDelete: () {
                  favoritesController.deleteFavorite(userId, product.docId!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
