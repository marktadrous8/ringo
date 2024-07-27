import 'package:flutter/material.dart';

import 'colors.dart';

Widget buildBottomNavigationBar() {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 8,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.grid_view, color: AppColors.neutral400),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.folder, color: AppColors.neutral400),
          onPressed: () {},
        ),
        SizedBox(width: 48), // The space for the floating action button
        IconButton(
          icon: Icon(Icons.calendar_today, color: AppColors.neutral400),
          onPressed: () {},
        ),
        IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/icons/user.png'), // Replace with your user icon path
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}
