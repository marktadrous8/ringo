import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ringo/utils/project_card.dart';
import 'package:ringo/utils/custom_text_field.dart';
import '../models/project_card_data.dart';
import '../utils/build_productivity_chart.dart';
import '../utils/colors.dart';

class ProjectSummaryScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final List<ProjectCardData> projectCards = [
    ProjectCardData(
      count: '10',
      label: 'Project In Progress',
      color: AppColors.blue_item,
      svgIconPath: 'assets/eye.svg',
    ),
    ProjectCardData(
      count: '24',
      label: 'Project Completed',
      color: AppColors.green_item,
      svgIconPath: 'assets/eye.svg',
    ),
    ProjectCardData(
      count: '5',
      label: 'Project Cancelled',
      color: AppColors.red_item,
      svgIconPath: 'assets/eye.svg',
    ),
  ];

  ProjectSummaryScreen({super.key});

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
            'Project Summary',
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
                  'assets/notification.svg', // Replace with your notification icon path
                  color: AppColors.neutral900,
                  height: 24,
                  width: 24,
                ),
              ),

            ],
          ),
          const SizedBox(width: 16),

        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Divider(height: 6,color: AppColors.neutral200,),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                const SizedBox(height: 16),
                _buildProjectCards(),
                const SizedBox(height: 16),
                _buildViewAllProjectsButton(),
                const SizedBox(height: 16),
                _buildProductivityChart(),
              ],
            ),
          ),
        ],
      ),
      );
  }

  Widget _buildSearchBar() {
    return CustomTextField(label: "Search", type: "search", controller: searchController);
  }

  Widget _buildProjectCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: projectCards.map((data) => ProjectCard(data: data)).toList(),
    );
  }
}

Widget _buildProjectCard(String count, String status, Color color) {
  return Container(
    width: 100,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          status,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Urbanist',
          ),
        ),
      ],
    ),
  );
}

Widget _buildViewAllProjectsButton() {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      side: BorderSide(color: AppColors.neutral900), // Changed to match the border color in the image
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Increased radius for more rounded corners
      ),
      padding: EdgeInsets.symmetric(vertical: 16), // Ensured consistent padding
    ),
    child: Container(
      width: double.infinity,
      child: Center(
        child: Text(
          'View All Project',
          style: TextStyle(
            color: AppColors.neutral900,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist',
          ),
        ),
      ),
    ),
  );
}
Widget _buildProductivityChart() {
  // Placeholder widget for productivity chart
  // Replace with actual chart implementation
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
     buildProductivityChart(),
    ],
  );
}