import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ringo/screens/schedule_screen.dart';
import 'package:ringo/utils/colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  late TabController _tabController;
  List<String> scheduleItems = [];
  List<Map<String, dynamic>> taskItems = []; // Updated to store task status

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    generateRandomData();
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        generateRandomData();
      });
  }

  void generateRandomData() {
    // Generate dummy schedule and task data
    scheduleItems = List.generate(5, (index) => 'Schedule Item ${index + 1}');
    taskItems = List.generate(5, (index) => {
      'title': 'Task Item ${index + 1}',
      'dueDate': 'Mon, 12 Jan 2023',
      'isCompleted': Random().nextBool(),
    });
    taskItems.shuffle(); // Randomly shuffle task items
  }

  void navigateWeek(int delta) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: delta * 7));
      generateRandomData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.neutral900),
          onPressed: () {},
        ),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Calendar',
            style: TextStyle(
              color: AppColors.neutral900,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Urbanist',
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: SvgPicture.asset(
                  'assets/notification.svg',
                  color: AppColors.neutral900,
                  height: 24,
                  width: 24,
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        color: AppColors.neutral100,
        child: Column(
          children: [
            Container(height: 16,color: AppColors.neutral0,),
            Divider(height: 6,color: AppColors.neutral200,),
            SizedBox(height: 16),
            _buildMonthYearSelector(),
            _buildWeekView(),
            SizedBox(height: 8),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ScheduleScreen(),
                  _buildTaskView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthYearSelector() {
    return Container(
      color: AppColors.neutral100,

      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _showDatePickerBottomSheet,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateFormat.yMMMM().format(selectedDate),
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      color: AppColors.neutral900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: AppColors.neutral900),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: AppColors.neutral0,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: AppColors.neutral900,size: 16,),
                  onPressed: () => navigateWeek(-1),
                ),
              ),
              SizedBox(width: 8), // Add some space between the icons
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: AppColors.neutral0,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: AppColors.neutral900,size: 16),
                  onPressed: () => navigateWeek(1),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWeekView() {
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final daysOfWeek = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Container(
      color: AppColors.neutral100,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          final day = daysOfWeek[index];
          final isSelected = day.day == selectedDate.day && day.month == selectedDate.month && day.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = day;
                generateRandomData();
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0,right: 4,top: 8,bottom: 8),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.neutral900 : AppColors.neutral0,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.E().format(day).toUpperCase(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black, // Change unselected day text color to black
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black, // Change unselected day text color to black
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.neutral900,
      unselectedLabelColor: AppColors.neutral500,
      indicatorColor: AppColors.neutral900,
      labelStyle: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      tabs: [
        Tab(text: 'Schedule'),
        Tab(text: 'Task'),
      ],
    );
  }

  Widget _buildScheduleView() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: scheduleItems.length,
      itemBuilder: (context, index) {
        return _buildTimelineEvent(scheduleItems[index], '${9 + index}:00 AM - ${10 + index}:00 AM', AppColors.blue);
      },
    );
  }

  Widget _buildTimelineEvent(String title, String time, Color color) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: true,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: color,
        padding: EdgeInsets.all(6),
      ),
      endChild: Container(
        constraints: BoxConstraints(minHeight: 80),
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.neutral900,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: AppColors.neutral500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskView() {
    return ListView.builder(
        padding: EdgeInsets.all(16),
      itemCount: taskItems.length,
      itemBuilder: (context, index) {
        return _buildTaskItem(index);
      },
    );
  }

  Widget _buildTaskItem(int index) {
    final task = taskItems[index];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        borderRadius: BorderRadius.circular(12), // More rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 8, // Shadow blur radius
            offset: Offset(0, 4), // Shadow offset
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: TextStyle(
                    fontFamily: 'Urbanist', // Custom font
                    color: AppColors.neutral900,
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Adjusted font size
                  ),
                ),
                SizedBox(height: 4), // Spacing between title and due date
                Text(
                  'Due Date: ${task['dueDate']}',
                  style: TextStyle(
                    fontFamily: 'Urbanist', // Custom font
                    color: AppColors.neutral500,
                    fontSize: 14, // Adjusted font size
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                taskItems[index]['isCompleted'] = !taskItems[index]['isCompleted'];
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: task['isCompleted'] ? AppColors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(6), // Square shape
                border: Border.all(color: AppColors.neutral200),
              ),
              child: task['isCompleted']
                  ? Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
  void _showDatePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true, // Ensure the bottom sheet can expand fully
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6, // Initial height as a fraction of the screen height
          minChildSize: 0.4, // Minimum height
          maxChildSize: 0.9, // Maximum height
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensure the column does not take up more space than necessary
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose Date',
                          style: TextStyle(
                            color: AppColors.neutral900,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: AppColors.neutral900),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.neutral200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CalendarDatePicker(
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          onDateChanged: (newDate) {
                            setState(() {
                              selectedDate = newDate;
                            });
                          },
                          selectableDayPredicate: (DateTime day) {
                            return true; // Allow all dates to be selectable
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity, // Make the button take full width
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          generateRandomData();
                        },
                        child: Text('Continue'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: AppColors.neutral900,
                          padding: EdgeInsets.symmetric(vertical: 16), // Increased padding for the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }}