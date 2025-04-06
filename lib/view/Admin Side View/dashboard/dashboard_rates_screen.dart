import "package:digital_kabaria_app/Utils/app_colors.dart";
import "package:digital_kabaria_app/common/custom_button.dart";
import "package:digital_kabaria_app/controllers/rates_controller.dart";
import "package:digital_kabaria_app/utils/app_strings.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../../common/custom_text_form_field.dart";

class DashboardRatesScreen extends StatelessWidget {
  DashboardRatesScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final RatesController controller = Get.put(RatesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            CustomTextFormField(
              controller: titleController,
              hintText: "Title",
              flag: true,
            ),
            const SizedBox(height: 10.0),
            CustomTextFormField(
              controller: priceController,
              hintText: "Price",
              flag: true,
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              btnHeight: 40,
              btnWidth: 200,
              onPressed: () {
                controller.addRates(
                  context,
                  title: titleController.text,
                  price: priceController.text,
                );
              },
              text: AppStrings.submit,
              btnColor: AppColors.appColor,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: controller.getRates(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error fetching data"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No rates found"),
                    );
                  }

                  final rates = snapshot.data!;

                  return ListView.builder(
                    itemCount: rates.length,
                    itemBuilder: (context, index) {
                      final rate = rates[index];
                      final String id = rate['id']; // Firebase document ID
                      final String title = rate['title'];
                      final String price = rate['price'];

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: ListTile(
                          title: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "PKR $price",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit,
                                    color: AppColors
                                        .appColor), // Customize color if needed
                                onPressed: () {
                                  // Populate the controllers with the current values
                                  titleController.text = title;
                                  priceController.text = price;

                                  // Open an edit dialog or navigate to an edit page
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("Edit Item"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                                labelText: "Title"),
                                          ),
                                          TextField(
                                            controller: priceController,
                                            decoration: const InputDecoration(
                                                labelText: "Price"),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(ctx).pop(),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Call the update function with the new values
                                            controller.editRates(context, id,
                                                title:
                                                    titleController.text.trim(),
                                                price: priceController.text
                                                    .trim());
                                            Navigator.of(ctx).pop();
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  controller.deleteRate(id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
