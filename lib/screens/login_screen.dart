
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ringo/screens/home_screen.dart';
import 'package:ringo/screens/project_summary_screen.dart';

import '../utils/colors.dart';
import '../utils/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = usernameController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  _Header(),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Username / Email',
                    type: 'email',

                    controller: usernameController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Password',
                    type: 'password',
                    controller: passwordController,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.neutral600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _LoginButton(
                    isEnabled: isButtonEnabled,
                    usernameController: usernameController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Or login with account',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.neutral600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SocialLoginButton(
                    label: 'Continue with Google',
                    iconPath: 'assets/google_icon.svg',
                  ),
                  const SizedBox(height: 16),
                  _SocialLoginButton(
                    label: 'Continue with Facebook',
                    iconPath: 'assets/facebook_icon.svg',
                  ),
                  const SizedBox(height: 16),
                  _SocialLoginButton(
                    label: 'Continue with Apple',
                    iconPath: 'assets/apple_icon.svg',
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: AppColors.neutral500,
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                        ),
                        children: [
                          TextSpan(
                            text: 'Register Here',
                            style: TextStyle(
                              color: AppColors.neutral700,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                            // Add gesture recognizer for navigation here
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Urbanist',
            color: AppColors.neutral700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sign in to your account',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Urbanist',
            color: AppColors.neutral500,
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bool isEnabled;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const _LoginButton({
    Key? key,
    required this.isEnabled,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          // Perform login action
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.neutral900 : AppColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Urbanist',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String label;
  final String iconPath;

  const _SocialLoginButton({required this.label, required this.iconPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: AppColors.neutral0,
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(color: AppColors.neutral200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              iconPath,
              height: 24,
            ),
          ),
          Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Urbanist',
                color: AppColors.neutral900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}