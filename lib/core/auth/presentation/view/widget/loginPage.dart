import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/resources/app_size.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/resources/style_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {}); // To update border color on focus change
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _validateAndLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty && password.isEmpty) {
      _showErrorMessage('Please enter your username and password');
      return;
    } else if (username.isEmpty) {
      _showErrorMessage('Please enter your username or email');
      return;
    } else if (password.isEmpty) {
      _showErrorMessage('Please enter your password');
      return;
    }

    // If all fields are valid, proceed
    Navigator.pushReplacementNamed(context, '/home');
  }

  // New method to validate before navigating to forgot password
  void _validateBeforeForgotPassword() {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      _showErrorMessage(
        'Please enter your username or email to recover password',
      );
      return;
    }

    // If username is not empty, proceed to forgot password screen
    // You might want to pass the username to the next screen
    Navigator.pushNamed(context, '/forgot-password-phone', arguments: username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MarketiColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingExtraLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Skip Button styled with border
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: MarketiColors.primaryBlue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Skip',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: MarketiColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Centered Larger Logo
              Center(child: Image.asset(AppAssets.logo, height: 200)),
              const SizedBox(height: 20),
              // Username/Email input
              TextField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Username or Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _usernameFocusNode.hasFocus
                          ? MarketiColors.primaryBlue
                          : MarketiColors.gray300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: MarketiColors.gray300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: MarketiColors.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              // Password input
              TextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: _passwordFocusNode.hasFocus
                          ? MarketiColors.primaryBlue
                          : MarketiColors.gray300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: MarketiColors.gray300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: MarketiColors.primaryBlue),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.paddingMedium),
              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: MarketiColors.primaryBlue,
                      ),
                      Text('Remember Me', style: AppTextStyles.bodyMedium),
                    ],
                  ),
                  TextButton(
                    onPressed:
                        _validateBeforeForgotPassword, // Updated to use new validation method
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: MarketiColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.paddingExtraLarge),
              // Log In Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateAndLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MarketiColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: MarketiColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Divider with "Or Continue With"
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.paddingMedium,
                    ),
                    child: Text(
                      'Or Continue With',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: MarketiColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              // Social login buttons inside auth_bg container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                      onPressed: () {},
                    ),
                    SizedBox(width: 11),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.google, color: Colors.red),
                    ),
                    SizedBox(width: 11),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.twitter),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Register prompt
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Are you new in Marketi? ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: MarketiColors.textPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: MarketiColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/sign-up');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
