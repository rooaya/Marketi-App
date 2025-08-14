import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/core/helpers/validetor.dart';
import 'package:marketiapp/core/theme/app_size.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/theme/style_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketiapp/features/auth/data/models/signin_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final String? initialEmail;

  const LoginScreen({super.key, required this.onLoginSuccess, this.initialEmail});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _rememberMe = false;
  bool _isLoading = false;
  late ApiConsumer _apiConsumer;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
    
    _apiConsumer = DioConsumer(
      dio: Dio(),
      getToken: () async => null,
    );

    if (widget.initialEmail != null) {
      _emailController.text = widget.initialEmail!;
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = SigninRequest(email: email, password: password);
      final response = await _apiConsumer.post(
        EndPoints.signIn,
        data: request.toJson(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
      await prefs.setString('email', response['user']['email']);
      await prefs.setBool('isLoggedIn', true);
      
      if (_rememberMe) {
        await prefs.setString('savedEmail', email);
        await prefs.setString('savedPassword', password);
      }
      
      widget.onLoginSuccess();
    } catch (e) {
      _showErrorMessage('Login failed: Invalid credentials');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _validateBeforeForgotPassword() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showErrorMessage('Please enter your email to recover password');
      return;
    }
    Navigator.pushNamed(context, '/forgot-password-email', arguments: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MarketiColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingExtraLarge),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                Center(child: Image.asset(AppAssets.logo, height: 200)),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) => TValidator.validateEmail(value),
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _emailFocusNode.hasFocus
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
                TextFormField(
                  validator: (value) => TValidator.validatePassword(value),
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
                      onPressed: _validateBeforeForgotPassword,
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MarketiColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: MarketiColors.white)
                        : Text(
                            'Log In',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: MarketiColors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMedium),
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
                      const SizedBox(width: 11),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.google, color: Colors.red),
                      ),
                      const SizedBox(width: 11),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.twitter),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
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
      ),
    );
  }
}