import 'package:flutter/material.dart';
import 'bar_chart.dart';
import 'colors.dart'; // Import the BarChartWidget

Widget buildProductivityChart() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Productivity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
              fontSize: 18,
              color: AppColors.neutral900,
            ),
          ),
          Icon(
            Icons.more_horiz,
            color: AppColors.neutral900,
          ),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BarChartWidget(),
      ),
    ],
  );
}