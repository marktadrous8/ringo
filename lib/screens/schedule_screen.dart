import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ringo/utils/colors.dart';

class ScheduleScreen extends StatelessWidget {
  final List<Map<String, dynamic>> scheduleItems = [
    {
      'time': '01:00',
      'title': 'Sprint Review Period 02 in May 2022',
      'color': Colors.purple,
      'textColor': Colors.purple,
      'duration': '09:00 - 10:00',
    },
    {
      'time': '02:00',
      'title': 'Meeting with Client',
      'color': Colors.orange,
      'textColor': Colors.orange,
      'duration': '11:00 - 12:00',
    },
    {
      'time': '05:00',
      'title': 'Daily Standup',
      'color': Colors.green,
      'textColor': Colors.green,
      'duration': '12:00 - 12:30',
    },
    {
      'time': '12:30',
      'title': 'Lunch Break',
      'color': Colors.blue,
      'textColor': Colors.blue,
      'duration': '12:30 - 13:00',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16),
        itemCount: 24, // 24 hours in a day
        itemBuilder: (context, index) {
          final hour = index.toString().padLeft(2, '0');
          final formattedTime = '$hour:00';
          final task = scheduleItems.firstWhere(
                (item) => item['time'] == formattedTime,
            orElse: () => {},
          );

          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 2,
                    color: AppColors.neutral200,
                    margin: EdgeInsets.only(left: 64, right: 16),
                  ),
                  Stack(

                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            padding: EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 16,
                                    color: AppColors.neutral900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height: 85, // Ensure each hour has equal height
                                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: task.isNotEmpty ? task['color'].withOpacity(0.2) : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: task.isNotEmpty ? task['color'] : Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft: Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.all(16),
                                                child: task.isNotEmpty
                                                    ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      task['title'],
                                                      style: TextStyle(
                                                        fontFamily: 'Urbanist',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: AppColors.neutral900,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.watch_later, size: 16, color: AppColors.neutral500),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          task['duration'],
                                                          style: TextStyle(
                                                            fontFamily: 'Urbanist',
                                                            fontSize: 16,
                                                            color: AppColors.neutral500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                                    : null, // Ensure the container is empty if no task
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (index == 3) // Show the static time indicator at 3rd hour (3:30)
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0, left: 16,right: 16),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                child: Text(
                                  "03:30",
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.neutral900,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.neutral900,
                                          width: 1, // Adjust the width of the border as needed
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 2,
                                        color: AppColors.neutral900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      )
    );
  }

}