import 'dart:math';

import 'package:digital_kabaria_app/model/product_model.dart';
import 'package:digital_kabaria_app/view/Seller%20View/bids_view.dart';
import 'package:flutter/material.dart';

class ViewAllBidsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ViewAllBidsScreen({super.key, required this.productModel});

  @override
  State<ViewAllBidsScreen> createState() => _ViewAllBidsScreenState();
}

class _ViewAllBidsScreenState extends State<ViewAllBidsScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: BidsView(
          productId: widget.productModel.docId ?? '',
          originalPrice: widget.productModel.price,
        ),
      ),
    );
  }
}
