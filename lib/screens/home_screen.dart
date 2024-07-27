import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ringo/utils/colors.dart';
import 'calendar_screen.dart';
import 'project_summary_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default to Project Summary screen

  final List<Widget> _screens = [
    PlaceholderScreen(title: 'Home'),
    ProjectSummaryScreen(),
    CalendarScreen(),
    PlaceholderScreen(title: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the BottomAppBar
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomAppBar(


            elevation: 0,

            shape: CircularNotchedRectangle(),
            child: Container(
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(icon: SvgPicture.asset('assets/apps.svg',),

                    onPressed: () => _onItemTapped(0),
                  ),
                  IconButton(icon: SvgPicture.asset(_selectedIndex == 1 ?'assets/project_clicked.svg':'assets/project.svg',),

                    onPressed: () => _onItemTapped(1),
                  ),
                  SizedBox(width: 40), // The dummy child to make space for FAB
                  IconButton(icon: SvgPicture.asset(_selectedIndex == 2 ?'assets/calender_clicked.svg':'assets/calender.svg',),
                    onPressed: () => _onItemTapped(2),
                  ),
                  IconButton(
                    icon: CircleAvatar(
                      backgroundImage: AssetImage('assets/img.png'), // Replace with your user icon path
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.neutral900,
        child: Icon(Icons.add,color: AppColors.neutral0,),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Urbanist'),
      ),
    );
  }
}