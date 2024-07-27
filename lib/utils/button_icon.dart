import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ringo/utils/colors.dart';

class SvgIconButton extends StatelessWidget {
  final String assetPath;
  final int index;
  final int selectedIndex;
  final Function(int) onItemTapped;

  SvgIconButton({
    required this.assetPath,
    required this.index,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        assetPath,
        color: index == selectedIndex ? AppColors.neutral900 : AppColors.neutral200,
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}