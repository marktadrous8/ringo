import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ringo/utils/colors.dart';

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(

          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (BarChartGroupData group) => AppColors.neutral900,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(

                '${56}%',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                switch (value.toInt()) {
                  case 0:
                    return Text('Jan', style: TextStyle(color: AppColors.neutral500, fontWeight: FontWeight.bold));
                  case 1:
                    return Text('Feb', style: TextStyle(color: AppColors.neutral500, fontWeight: FontWeight.bold));
                  case 2:
                    return Text('Mar', style: TextStyle(color: AppColors.neutral500, fontWeight: FontWeight.bold));
                  case 3:
                    return Text('Apr', style: TextStyle(color: AppColors.neutral900, fontWeight: FontWeight.bold));
                  case 4:
                    return Text('May', style: TextStyle(color: AppColors.neutral500, fontWeight: FontWeight.bold));
                  case 5:
                    return Text('Jun', style: TextStyle(color: AppColors.neutral500, fontWeight: FontWeight.bold));
                  default:
                    return Text('', style: TextStyle(color: AppColors.neutral500, fontWeight: FontWeight.bold));
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false), // Hide grid lines
        barGroups: [
          makeGroupData(0, 50, isTouched: false),
          makeGroupData(1, 70, isTouched: false),
          makeGroupData(2, 40, isTouched: false),
          makeGroupData(3, 56, isTouched: true),
          makeGroupData(4, 80, isTouched: false),
          makeGroupData(5, 90, isTouched: false),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, {bool isTouched = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? AppColors.neutral900 : AppColors.neutral200,
          width: 48,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      showingTooltipIndicators: isTouched ? [0] : [],
    );
  }
}