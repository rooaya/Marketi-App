import 'package:flutter/material.dart';
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

void main() {
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
          onNextPressed: () =>
              Navigator.pushReplacementNamed(context, '/onboarding2'),
          onSkipPressed: () =>
              Navigator.pushReplacementNamed(context, '/login'),
        ),
        '/onboarding2': (context) => OnboardingPage2(
          onNextPressed: () =>
              Navigator.pushReplacementNamed(context, '/onboarding3'),
          onBackPressed: () => Navigator.pop(context),
          onSkipPressed: () =>
              Navigator.pushReplacementNamed(context, '/login'),
        ),
        '/onboarding3': (context) => OnboardingPage3(
          onGetStartedPressed: () =>
              Navigator.pushReplacementNamed(context, '/login'),
          onBackPressed: () => Navigator.pop(context),
        ),
        '/sign-up': (context) => const SignUpScreen(),
  '/login': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return LoginScreen(
      onLoginSuccess: () => Navigator.pushReplacementNamed(context, '/home_screen'),
      initialEmail: args?['email']?.toString(),
    );
  },
        '/forgot-password-phone': (context) => ForgotPasswordPhoneScreen(),
        // In your routes:
        '/forgot-password-email': (context) => ForgotPasswordEmailScreen(),
        '/verification-email': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return VerificationCodeEmail(email: args['email'] as String);
  },
  '/create-password': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return CreateNewPasswordScreen(
      email: args['email'] as String,
      resetCode: args['resetCode'] as String,
    );
  },
        '/congrates-page': (context) => CongratulationsScreen(),
        '/home_screen': (context) => ProductHomePage(),
      },
    );
  }
}
