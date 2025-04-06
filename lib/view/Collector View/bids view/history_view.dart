import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/controllers/bid/bids_controller_getx.dart';
import 'package:digital_kabaria_app/view/Collector%20View/bids%20view/custom_tile_bid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryViewScreen extends StatefulWidget {
  final String productId;

  const HistoryViewScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<HistoryViewScreen> createState() => _HistoryViewScreenState();
}

class _HistoryViewScreenState extends State<HistoryViewScreen> {
  BidsController? controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BidsController());
    Future.microtask(() => controller?.fetchHistory(widget.productId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('History View'),
        ),
        body: Obx(() {
          if (controller!.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller!.historyList.isEmpty) {
            return const Center(child: Text('No bids found in history'));
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(15.sp),
            itemCount: controller?.historyList.length ?? 0,
            itemBuilder: (context, index) {
              final bid = controller?.historyList[index];
              if (bid == null) return const SizedBox.shrink();

              return BidCardTile(
                bidderName: bid['name'],
                phone: bid['phone'],
                bidAmount: '${bid['bidAmount']}',
                isShowDelete: true,
                onDeletePressed: () async {
                  try {
                    // Delete document by ID if available
                    await FirebaseFirestore.instance
                        .collection('bids')
                        .doc(widget.productId)
                        .collection('history')
                        .doc(bid['id'])
                        .delete();

                    controller!.historyList.removeAt(index);
                    print('Document deleted successfully');
                  } catch (e) {
                    print('Error deleting document: $e');
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}
