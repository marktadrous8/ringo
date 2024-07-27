import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'colors.dart'; // Import the colors.dart file

class CustomTextField extends StatefulWidget {
  final String label;
  final String type; // 'password', 'email', 'search'
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.type,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Urbanist',
            color: AppColors.neutral900,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextField(
          controller: widget.controller,
          obscureText: widget.type == 'password' && obscureText,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16,
            color: AppColors.neutral900,
          ),
          decoration: InputDecoration(
            hintText: _getHintText(),
            hintStyle: TextStyle(
              color: AppColors.neutral400,
              fontFamily: 'Urbanist',
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neutral400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neutral400),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neutral900),
            ),
            suffixIcon: _getSuffixIcon(),
          ),
          obscuringCharacter: '•', // Use '•' for stars
        ),
      ],
    );
  }

  String _getHintText() {
    switch (widget.type) {
      case 'password':
        return 'Enter password here';
      case 'email':
        return 'Username / Email';
      case 'search':
        return 'Search project here';
      default:
        return '';
    }
  }

  Widget? _getSuffixIcon() {
    if (widget.type == 'password') {
      return IconButton(
        icon: SvgPicture.asset(
          obscureText ? 'assets/eye.svg' : 'assets/eye_closed.svg',
        ),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      );
    } else if (widget.type == 'search') {
      return IconButton(
        icon: SvgPicture.asset(
         'assets/search.svg',
        ),
        onPressed: () {
          setState(() {

          });
        },
      );
    }
    return null;
  }
}