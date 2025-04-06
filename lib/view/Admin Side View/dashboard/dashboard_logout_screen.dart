import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_kabaria_app/Utils/app_colors.dart';
import 'package:digital_kabaria_app/Utils/app_text.dart';

class DashboardFeedback extends StatefulWidget {
  const DashboardFeedback({Key? key}) : super(key: key);

  @override
  State<DashboardFeedback> createState() => _DashboardFeedbackState();
}

class _DashboardFeedbackState extends State<DashboardFeedback> {
  final Map<String, TextEditingController> _replyControllers = {};
  final Map<String, bool> _isEditingReply = {};

  // Method to submit or edit a reply to Firestore
  Future<void> submitReply(String feedbackId, String reply) async {
    try {
      await FirebaseFirestore.instance
          .collection('feedback')
          .doc(feedbackId)
          .update({'reply': reply});

      _replyControllers[feedbackId]?.clear();
      setState(() {
        _isEditingReply[feedbackId] = false; // Stop editing after submission
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reply submitted successfully!")),
      );
    } catch (e) {
      print("Error submitting reply: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit reply.")),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const AppText(
          text: "Feedback",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.appColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching feedback."));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No feedback available."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final feedback = snapshot.data!.docs[index];
              final feedbackData = feedback.data() as Map<String, dynamic>;

              final feedbackId = feedback.id;
              final title = feedbackData['title'] ?? "No Title";
              final description =
                  feedbackData['description'] ?? "No Description";
              final reply = feedbackData['reply'] ?? "";

              _replyControllers.putIfAbsent(
                feedbackId,
                () => TextEditingController(text: reply),
              );

              _isEditingReply.putIfAbsent(feedbackId, () => false);

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Section
                    const Text(
                      "Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description Section
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Admin Reply Section
                    const Text(
                      "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),

                    if (_isEditingReply[feedbackId]!)
                      Column(
                        children: [
                          TextField(
                            controller: _replyControllers[feedbackId],
                            decoration: InputDecoration(
                              hintText: "Reply to user",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              filled: true,
                              fillColor: Colors.grey[300],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                final replyText =
                                    _replyControllers[feedbackId]?.text.trim();
                                if (replyText != null && replyText.isNotEmpty) {
                                  submitReply(feedbackId, replyText);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Reply cannot be empty!")),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appColor,
                              ),
                              child: const Text(
                                "Send Reply",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (reply.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                reply,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isEditingReply[feedbackId] = true;
                                });
                              },
                              child: const Text("Reply"),
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
      ),
    );
  }
}
