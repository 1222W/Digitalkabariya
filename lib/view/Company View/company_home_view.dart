import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/custom_button.dart';
import '../../controllers/bid/bid_controller.dart';
import '../../controllers/company_controllers/company_home_controller.dart';
import '../../controllers/seller_controllers/seller_profile_controller.dart';
import '../../model/product_model.dart';
import '../../utils/app_colors.dart';
import '../Company View/company_product_detail_page.dart';
import '../Company View/widgets/companyCustomCard.dart';
import '../Company View/widgets/company_custom_button.dart';

class CompanyHomeView extends StatefulWidget {
  const CompanyHomeView({super.key});

  @override
  State<CompanyHomeView> createState() => _CompanyHomeViewState();
}

class _CompanyHomeViewState extends State<CompanyHomeView> {
  final CompanyHomeController controller = Get.put(CompanyHomeController());
  final SellerProfileController sellerController =
      Get.put(SellerProfileController());
  final BidController bidController = Get.put(BidController());

  final Map<String, String> buttonTexts = {};
  final Map<String, bool> buttonStates = {};

  @override
  void initState() {
    super.initState();
    controller.getProductData();
  }

  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    try {
      // Reference to the Firestore collection
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Check if the user exists
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data(); // Return user data as a map
      } else {
        print("User not found");
        return null; // User not found
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null; // Return null on error
    }
  }

  Future<void> checkBidding(String productDocId, String userID) async {
    final bidDoc = await FirebaseFirestore.instance
        .collection('bids')
        .doc(productDocId)
        .collection('users')
        .doc(userID)
        .get();

    if (bidDoc.exists) {
      final bidData = bidDoc.data();
      final isAccept = bidData?['isAccept'] ?? false;

      setState(() {
        buttonTexts[productDocId] = isAccept ? "Approved".tr : "Pending".tr;
        buttonStates[productDocId] = false;
      });
    } else {
      setState(() {
        buttonTexts[productDocId] = "Send Bid".tr;
        buttonStates[productDocId] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: StreamBuilder<List<ProductModel>>(
        stream: controller.getProductData(),
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No products found',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final List<ProductModel> products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final ProductModel product = products[index];
              final String productDocId = product.docId!;
              final String currentUserUid =
                  FirebaseAuth.instance.currentUser!.uid;

              // Ensure button state is initialized for the product
              if (!buttonTexts.containsKey(productDocId)) {
                checkBidding(productDocId, currentUserUid);
              }

              return GestureDetector(
                onTap: () {
                  Get.to(() => CompanyProductDetailPage(docId: productDocId));
                },
                child: CompanyCustomCard(
                  title: product.name,
                  description: product.description,
                  price: int.tryParse(product.price ?? '0') ?? 0,
                  images: product.images.isNotEmpty ? product.images[0] : '',
                  buttonWidget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CompanyCustomButton(
                      text: buttonTexts[productDocId] ?? "Loading...",
                      textColor: Colors.white,
                      btnColor: AppColors.appColor,
                      onPressed: buttonStates[productDocId] == true
                          ? () async {
                              TextEditingController priceController =
                                  TextEditingController();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text(
                                      "Enter Bid Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: priceController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Enter price",
                                            labelText: "Price",
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.brown,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final enteredPrice =
                                                priceController.text;

                                            if (enteredPrice.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Please enter a price"),
                                                ),
                                              );
                                              return;
                                            }

                                            // Fetch minimum bid amount from Firebase
                                            final productDoc =
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        'products') // Replace with your products collection
                                                    .doc(productDocId)
                                                    .get();

                                            // if (productDoc.exists) {

                                            final minBidAmount = productDoc
                                                    .data()?['minimumAmount'] ??
                                                0;

                                            log("message $minBidAmount");

                                            if (int.parse(enteredPrice) <
                                                minBidAmount) {
                                              // Show error if the bid is below minimum
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "The bid amount must be at least $minBidAmount"),
                                                ),
                                              );
                                              return;
                                            } else {
                                              final data = await fetchUserData(
                                                  currentUserUid);

                                              // Save the bid in Firestore
                                              await FirebaseFirestore.instance
                                                  .collection('bids')
                                                  .doc(productDocId)
                                                  .collection('users')
                                                  .doc(currentUserUid)
                                                  .set({
                                                "name": data?['full_name'],
                                                "price":
                                                    int.parse(enteredPrice),
                                                "phone": data?['phone_number'],
                                                'isAccept': false,
                                              });

                                              setState(() {
                                                buttonTexts[productDocId] =
                                                    "Pending";
                                              });

                                              Navigator.pop(context);
                                            }

                                            // Fetch user data

                                            // } else {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     const SnackBar(
                                            //       content:
                                            //           Text("Product not found"),
                                            //     ),
                                            //   );
                                            // }
                                          },
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          : () {},
                    ),
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
