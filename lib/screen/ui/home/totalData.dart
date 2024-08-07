import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../src/constant.dart';

class HomeTotalAset extends StatefulWidget {
    final num 
      target1,
      target2,
      target3,
      target4;


      const HomeTotalAset(
      {Key? key,
      required this.target1,
      required this.target2,
      required this.target3,
      required this.target4})
      : super(key: key);

  @override
  State<HomeTotalAset> createState() => _HomeTotalAsetState();
}

  int touchedIndex = -1;
  int touchedGroupIndex = -1;


class _HomeTotalAsetState extends State<HomeTotalAset> {
  @override
  Widget build(BuildContext context) {
    return 
      PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 20,
          sections: showingSections(),
        ),
      );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: widget.target1.toDouble(),
            title: widget.target1.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrEdit,
            value: widget.target2.toDouble(),
            title: widget.target2.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrDelete,
            value: widget.target3.toDouble(),
            title: widget.target3.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
