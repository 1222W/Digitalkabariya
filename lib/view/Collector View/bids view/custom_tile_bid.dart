import 'package:flutter/material.dart';

class BidCardTile extends StatelessWidget {
  final String bidderName;
  final String bidAmount;
  // final String originalPrice;
  final String phone;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onDeletePressed;
  final isShowDelete;

  const BidCardTile(
      {Key? key,
      required this.bidderName,
      required this.bidAmount,
      // required this.originalPrice,
      required this.phone,
      this.onAccept,
      this.onReject,
      required this.isShowDelete,
      this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bidder Name
            Text.rich(
              TextSpan(
                text: 'Bid By  ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                children: [
                  TextSpan(
                    text: bidderName,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Bid Amount
            Text.rich(
              TextSpan(
                text: 'Bid Amount  ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                children: [
                  TextSpan(
                    text: '$bidAmount PKR',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Original Price
            // Text.rich(
            //   TextSpan(
            //     text: 'Original Price  ',
            //     style:
            //         const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            //     children: [
            //       TextSpan(
            //         text: '$originalPrice PKR',
            //         style: const TextStyle(fontWeight: FontWeight.normal),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 8),

            // Type
            Text.rich(
              TextSpan(
                text: 'Phone  ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                children: [
                  TextSpan(
                    text: phone,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Accept and Reject Buttons
            isShowDelete
                ? InkWell(
                    onTap: onDeletePressed,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      color: Colors.red,
                      child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: onAccept,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: OutlinedButton(
                            onPressed: onReject,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.brown, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Reject',
                              style: TextStyle(color: Colors.brown),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
