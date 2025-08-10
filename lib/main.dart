import 'package:flutter/material.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/CongratulationsScreen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/ForgotPasswordWithEmailScreen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/VerificationCodePhone.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/createNewPassword.dart';

import 'package:marketiapp/core/auth/presentation/view/widget/forgotPassword.dart';

import 'package:marketiapp/core/auth/presentation/view/widget/loginPage.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/onBoarding1.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/onBoarding2.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/onBoarding3.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/signupPage.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/splashScreen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/verificationCodeEmail.dart';

import 'package:marketiapp/core/resources/style_manager.dart';

void main() {
  runApp(const MarketiApp());
}

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketi',
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingFlow(),
        '/login': (context) => LoginScreen(),
        '/sign-up': (context) => SignUpScreen(),
        '/forgot-password-phone': (context) => ForgotPasswordPhoneScreen(),
        '/forgot-password-email': (context) => ForgotPasswordEmailScreen(),
        '/verification-phone': (context) => VerificationCodeScreen(),
        '/verification-email': (context) => VerificationCodeEmail(),
        '/create-password':(context)=> CreateNewPasswordScreen(),
        '/congrates-page':(context)=> CongratulationsScreen(),
        '/home': (context) =>
            const Placeholder(), // Replace with your home screen
      },
    );
  }
}

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skipToEnd() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        physics: const ClampingScrollPhysics(),
        children: [
          OnboardingPage1(onNextPressed: _nextPage, onSkipPressed: _skipToEnd),
          OnboardingPage2(
            onNextPressed: _nextPage,
            onSkipPressed: _skipToEnd,
            onBackPressed: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
          ),
          OnboardingPage3(
            onGetStartedPressed: _skipToEnd,
            onBackPressed: () => _pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }
}
