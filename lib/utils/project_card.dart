import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ringo/utils/colors.dart';
import '../models/project_card_data.dart';

class ProjectCard extends StatelessWidget {
  final ProjectCardData data;

  const ProjectCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            data.color.withOpacity(0.9),
            data.color.withOpacity(0.3),
          ],
          center: Alignment.center,
          focal: Alignment.center,
          focalRadius: 0.5,
          radius: 1.0,
          stops: [0.0, 1.0],
        ),

        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.count,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.neutral0,
                ),
              ),
              SvgPicture.asset(data.svgIconPath, color: AppColors.neutral0, height: 16, width: 16),

            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  data.label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    color: AppColors.neutral0,

                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}