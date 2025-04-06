import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InteractionChartWidget extends StatefulWidget {
  @override
  _InteractionChartWidgetState createState() => _InteractionChartWidgetState();
}

class _InteractionChartWidgetState extends State<InteractionChartWidget> {
  String _selectedValue = 'daily';

  // Static data for the chart
  final Map<String, List<BarChartGroupData>> _staticData = {
    'daily': List.generate(
        7,
        (index) => BarChartGroupData(x: index, barRods: [
              BarChartRodData(
                  toY: (index + 1) * 10.0, color: Colors.blueAccent),
              BarChartRodData(toY: (index + 1) * 5.0, color: Colors.redAccent),
            ])),
    'weekly': List.generate(
        7,
        (index) => BarChartGroupData(x: index, barRods: [
              BarChartRodData(
                  toY: (index + 1) * 15.0, color: Colors.blueAccent),
              BarChartRodData(toY: (index + 1) * 7.0, color: Colors.redAccent),
            ])),
    'monthly': List.generate(
        12,
        (index) => BarChartGroupData(x: index, barRods: [
              BarChartRodData(
                  toY: (index + 1) * 20.0, color: Colors.blueAccent),
              BarChartRodData(toY: (index + 1) * 10.0, color: Colors.redAccent),
            ])),
  };

  List<String> _getBottomTitles() {
    switch (_selectedValue) {
      case 'monthly':
        return [
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
      case 'weekly':
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case 'daily':
        return List.generate(7, (index) => 'Day ${index + 1}');
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildChartContainer(
      title: "Peak Interactions Time",
      hint: "Time of Days",
      selectedValue: _selectedValue,
      options: ['daily', 'weekly', 'monthly'],
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue!;
        });
      },
      chart: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: _staticData[_selectedValue]!.length * 60.0,
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 200,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameWidget: Row(
                    children: [
                      SizedBox(width: 30),
                      Text(
                        _selectedValue == 'daily'
                            ? 'Date Progress'
                            : _selectedValue == 'weekly'
                                ? 'Week Progress'
                                : 'Month Progress',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      final titles = _getBottomTitles();
                      final title = titles.isNotEmpty && index < titles.length
                          ? titles[index]
                          : '';
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: RotatedBox(
                    quarterTurns: 4,
                    child: Text(
                      'Frequency f(x)',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: _staticData[_selectedValue]!,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChartContainer({
    required String title,
    required String hint,
    required String? selectedValue,
    required List<String> options,
    required void Function(String?) onChanged,
    required Widget chart,
  }) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "GothamBold",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: selectedValue,
                hint: Text(hint),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                ),
                onChanged: onChanged,
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24),
            Expanded(child: chart),
          ],
        ),
      ),
    );
  }
}
