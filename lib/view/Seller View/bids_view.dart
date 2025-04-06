import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/controllers/bid/bids_controller_getx.dart';
import 'package:digital_kabaria_app/view/Collector%20View/bids%20view/custom_tile_bid.dart';
import 'package:digital_kabaria_app/view/Collector%20View/bids%20view/history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BidsView extends StatefulWidget {
  final String productId;
  final String originalPrice;

  const BidsView(
      {Key? key, required this.productId, required this.originalPrice})
      : super(key: key);

  @override
  State<BidsView> createState() => _BidsViewState();
}

class _BidsViewState extends State<BidsView> {
  BidsController? controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BidsController());
    controller?.fetchBidsData(
        widget.productId); // Ensure history is fetched when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bids details", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                push(
                  context,
                  HistoryViewScreen(
                    productId: widget.productId,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Obx(() {
            if (controller!.isLoading.value) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (controller!.bidsList.isEmpty) {
              return Center(child: Text('No bids found'));
            }

            return ListView.builder(
              padding: EdgeInsets.all(15.sp),
              itemCount: controller?.bidsList.length,
              itemBuilder: (context, index) {
                final bid = controller?.bidsList[index];
                return BidCardTile(
                  bidderName: bid?['name'] ?? '',
                  phone: bid?['phone'] ?? '',
                  bidAmount: '${bid?['price']}',
                  isShowDelete: false,
                  onAccept: () async {
                    if (bid != null) {
                      await FirebaseFirestore.instance
                          .collection('bids')
                          .doc(widget.productId)
                          .collection('history')
                          .doc(DateTime.now().toIso8601String())
                          .set({
                        'name': bid['name'],
                        'phone': bid['phone'],
                        'bidAmount': bid['price'],
                      }, SetOptions(merge: true));

                      try {
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('bids')
                            .doc(widget.productId)
                            .collection('users')
                            .where('name', isEqualTo: bid['name'])
                            .where('phone', isEqualTo: bid['phone'])
                            .limit(1)
                            .get();

                        if (querySnapshot.docs.isNotEmpty) {
                          await querySnapshot.docs.first.reference
                              .update({'isAccept': true});
                          controller?.bidsList.removeAt(index);
                        }
                      } catch (e) {
                        print('Error updating bid: $e');
                      }
                    }
                  },
                  onReject: () async {
                    if (bid != null) {
                      try {
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('bids')
                            .doc(widget.productId)
                            .collection('users')
                            .where('name', isEqualTo: bid['name'])
                            .where('phone', isEqualTo: bid['phone'])
                            .limit(1)
                            .get();

                        if (querySnapshot.docs.isNotEmpty) {
                          await querySnapshot.docs.first.reference.delete();
                          controller?.bidsList.removeAt(index);
                        }
                      } catch (e) {
                        print('Error rejecting bid: $e');
                      }
                    }
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
