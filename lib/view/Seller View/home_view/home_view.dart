import 'package:digital_kabaria_app/Common/custom_card_widget.dart';
import 'package:digital_kabaria_app/view/Seller%20View/home_view/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digital_kabaria_app/controllers/get_product_controller.dart';
import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:digital_kabaria_app/view/product/product_detail_page.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GetProductController controller = Get.put(GetProductController());
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';
  final List<String> selectedFilters = []; // To store selected filters

  final List<String> filterItems = [
    "Plastic".tr,
    'Metal'.tr,
    'Wood'.tr,
    'Paper'.tr,
    'Fabric'.tr,
    'Machinery'.tr,
  ];

  @override
  void initState() {
    super.initState();
    controller.getProductData();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.blue),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    "Select Filters".tr,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: filterItems.length,
                                      itemBuilder: (context, index) {
                                        return CheckboxListTile(
                                          title: Text(
                                            filterItems[index].tr,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          value: selectedFilters
                                              .contains(filterItems[index].tr),
                                          onChanged: (bool? value) {
                                            setModalState(() {
                                              if (value == true) {
                                                selectedFilters
                                                    .add(filterItems[index].tr);
                                              } else {
                                                selectedFilters
                                                    .remove(filterItems[index].tr);
                                              }
                                            });
                                          },
                                          activeColor: Colors.blue,
                                          checkColor: Colors.white,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setModalState(() {
                                            selectedFilters.clear();
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child:  Text(
                                          "Clear All".tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child:  Text(
                                          "Apply".tr,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {
                    Get.to(() => FavoritesScreen());
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<List<ProductModel>>(
            stream: controller.getProductData(),
            builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No products found')),
                );
              }

              final List<ProductModel> products = snapshot.data!;
              final filteredProducts = products.where((product) {
                final matchesSearch =
                    product.name.toLowerCase().contains(searchQuery) ||
                        product.description.toLowerCase().contains(searchQuery);
                final matchesFilters = selectedFilters.isEmpty ||
                    selectedFilters
                        .any((filter) => product.name.contains(filter));
                return !product.isSold! && matchesSearch && matchesFilters;
              }).toList();

              if (filteredProducts.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No products match your search')),
                );
              }

              return Expanded(
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final ProductModel product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailPage(docId: product.docId!));
                      },
                      child: CustomCardProduct(
                        productModel: product,
                        isPrice: true,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
