import 'package:digital_kabaria_app/Common/custom_button.dart';
import 'package:digital_kabaria_app/Utils/custom_navigation.dart';
import 'package:digital_kabaria_app/controllers/add_product_controller.dart';
import 'package:digital_kabaria_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    controller.getCurrentLocation();
  }

  AddProductController controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: GetBuilder<AddProductController>(
        builder: (_) {
          return Stack(
            children: [
              
              PlacePicker(
                apiKey: 'AIzaSyDka8c0sYp6KgWOnnwJwHsAzBxUZJTJZYY',
                initialPosition: _.center,
                useCurrentLocation: true,     
                        
                onPlacePicked: (result) {
                  setState(() {
                    _.selectedPlace = result;
                    // _.getAddressFromLatLng(LatLng(result.geometry!.location.lat, result.geometry!.location.lng));
                  });
                },
              ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        btnColor: AppColors.greenColor,
                      btnWidth: 150,
                      text: "Confirm",
                      onPressed: () {
                        pop(context);
                      },
                                      ),

                                      SizedBox(height: 20,)
                    ],
                  ),),

              if (_.address != null)
                Positioned(
                  top: 300.h,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _.address!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              
            ],
          );

        
                },
      ),
    );
  }
}

