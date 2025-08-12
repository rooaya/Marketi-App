import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/auth/presentation/widget/Congratulations/congratulation_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/CreatePass/create_new_pass.dart';
import 'package:marketiapp/features/auth/presentation/widget/ForgotPass/forgot_pass.dart';
import 'package:marketiapp/features/auth/presentation/widget/ForgotPass/forgot_pass_email.dart';
import 'package:marketiapp/features/auth/presentation/widget/HomeScreen/home_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/Login/login_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/OnBoarding/onboarding1_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/OnBoarding/onboarding2_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/OnBoarding/onboarding3_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/SignUp/sign_up_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/SplashScreen/splash_screen.dart';
import 'package:marketiapp/features/auth/presentation/widget/VerificationCode/verify_code_email.dart';
import 'package:marketiapp/features/auth/presentation/widget/VerificationCode/verify_code_phone.dart';
import 'package:marketiapp/models/signin_request.dart';
import 'package:marketiapp/utils/app_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MarketiApp());
}

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketi App',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding1': (context) => OnboardingPage1(
          onNextPressed: () {
            Navigator.pushReplacementNamed(context, '/onboarding2');
          },
          onSkipPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        '/onboarding2': (context) => OnboardingPage2(
          onNextPressed: () {
            Navigator.pushReplacementNamed(context, '/onboarding3');
          },
          onBackPressed: () {
            Navigator.pop(context);
          },
          onSkipPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        '/onboarding3': (context) => OnboardingPage3(
          onGetStartedPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          onBackPressed: () {
            Navigator.pop(context);
          },
        ),
        '/login': (context) => LoginScreen(
          onLoginSuccess: () async {
            // Save login state
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            Navigator.pushReplacementNamed(context, '/home_screen');
          },
        ),
        '/sign-up': (context) => SignUpScreen(),
        '/forgot-password-phone': (context) => ForgotPasswordPhoneScreen(),
        '/forgot-password-email': (context) => ForgotPasswordEmailScreen(),
        '/verification-phone': (context) => VerificationCodeScreen(),
        '/verification-email': (context) => VerificationCodeEmail(),
        '/create-password': (context) => CreateNewPasswordScreen(
          email: "rooaya52@gmail.com",
          resetCode: '12345',
        ),
        '/congrates-page': (context) => CongratulationsScreen(),
        '/home': (context) => const Placeholder(),
        '/home_screen': (context) => ProductHomePage(),
      },
    );
  }
}
