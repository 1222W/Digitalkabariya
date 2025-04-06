import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineGraphWidget extends StatefulWidget {
  const LineGraphWidget({super.key});

  @override
  _LineGraphWidgetState createState() => _LineGraphWidgetState();
}

class _LineGraphWidgetState extends State<LineGraphWidget> {
  String selectedPeriod = "Monthly"; // Default selected period
  List<FlSpot> monthlyData = [
    FlSpot(0, 700),
    FlSpot(1, 900),
    FlSpot(2, 800),
    FlSpot(3, 850),
    FlSpot(4, 950),
    FlSpot(5, 1000),
  ]; // Monthly Data
  List<FlSpot> yearlyData = [
    FlSpot(0, 1200),
    FlSpot(1, 1400),
    FlSpot(2, 1300),
    FlSpot(3, 1350),
    FlSpot(4, 1450),
    FlSpot(5, 1500),
    FlSpot(6, 1600),
    FlSpot(7, 1700),
    FlSpot(8, 1650),
    FlSpot(9, 1750),
    FlSpot(10, 1800),
    FlSpot(11, 1900),
  ]; // Yearly Data

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // Get screen size

    return Container(
      width: size.width * 0.60, // Set width to 60% of screen width
      height: 500, // Fixed height for the graph container
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Overview", // Title of the chart
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Dropdown menu for selecting the period (Monthly or Yearly)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedPeriod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPeriod = newValue!;
                });
              },
              items: <String>['Monthly', 'Yearly']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // The graph will fill the rest of the space
          Expanded(
            child: InteractionFrequencyChart(
              data: selectedPeriod == "Monthly" ? monthlyData : yearlyData,
              isMonthly: selectedPeriod == "Monthly",
            ), // The chart widget itself
          ),
        ],
      ),
    );
  }
}

class InteractionFrequencyChart extends StatelessWidget {
  final List<FlSpot> data;
  final bool isMonthly; // Add a flag to determine the data type

  const InteractionFrequencyChart({
    Key? key,
    required this.data,
    required this.isMonthly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0), // Padding for chart
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 100,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[300],
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  // Update titles based on the selected filter
                  final titles = isMonthly
                      ? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      : [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec'
                        ];
                  if (value.toInt() >= titles.length) return Container();
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      titles[value.toInt()],
                      style: style,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  // Replace dollar signs with PKR
                  String text;
                  if (value == 0) {
                    text = '₨0';
                  } else if (value == 250) {
                    text = '₨250';
                  } else if (value == 500) {
                    text = '₨500';
                  } else if (value == 750) {
                    text = '₨750';
                  } else if (value == 1000) {
                    text = '₨1k';
                  } else if (value == 1200) {
                    text = '₨1.2k';
                  } else if (value == 1400) {
                    text = '₨1.4k';
                  } else if (value == 1500) {
                    text = '₨1.5k';
                  } else if (value == 1800) {
                    text = '₨1.8k';
                  } else if (value == 1900) {
                    text = '₨1.9k';
                  } else {
                    text = '';
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(text, style: style),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          minX: 0,
          maxX: isMonthly ? 6 : 11, // Adjust for all 12 months
          minY: 0,
          maxY: 2000, // Adjust Y-axis range to fit data
          lineBarsData: [
            LineChartBarData(
              spots: data, // Use the selected data (monthly or yearly)
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.red.withOpacity(0.1)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
