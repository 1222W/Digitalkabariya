import 'package:digital_kabaria_app/Common/custom_text_form_field.dart';
import 'package:digital_kabaria_app/model/home_tab_model.dart';
import 'package:digital_kabaria_app/view/Admin%20Side%20View/dashboard/dashboard_widgets/home_tab_widgets.dart';
import 'package:digital_kabaria_app/view/charts/line_chart.dart';
import 'package:flutter/material.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  var data = HomeTabCardData();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * .050,
          ),
          // Container(

          //     width: width * .60,
          //     child: const CustomTextFormField(
          //       prefixIcon: Icon(Icons.search,),
          //       hintText: "Search",
          //     )),
          SizedBox(
            height: height * .020,
          ),
          SizedBox(
            height: 150,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 200,
              ),
              itemCount: data.data.length,
              itemBuilder: (context, index) {
                return HomeCardWidget(
                  icons: data.data[index].icon,
                  title: data.data[index].title,
                  subTitle: data.data[index].subTitle,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const LineChartWidget(),
          const SizedBox(
            height: 10.0,
          ),
          const LineGraphWidget(),

          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
