import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/Congratulations/congratulation_screen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/CreatePass/create_new_pass.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/ForgotPass/forgot_pass.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/ForgotPass/forgot_pass_email.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/Login/login_screen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/OnBoarding/onboarding1_screen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/OnBoarding/onboarding2_screen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/OnBoarding/onboarding3_screen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/SignUp/sign_up_screen.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/VerificationCode/verify_code_email.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/VerificationCode/verify_code_phone.dart';
import 'package:marketiapp/core/auth/presentation/view/widget/splashScreen/splashScreen.dart';

import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:marketiapp/core/resources/style_manager.dart';
import 'package:marketiapp/models/signin_request.dart';
import 'package:marketiapp/models/signin_response.dart';
import 'package:marketiapp/models/signup_request.dart';
import 'package:marketiapp/utils/app_setup.dart';

Future<void> main() async {
  runApp(const MarketiApp());
  final dio = createDio();
  final api = ApiConsumer(dio: dio);

  // Sign up example
  final signupRequest = SignupRequest(
    name: 'roaya',
    phone: '12345678',
    email: 'rooaya52@gmail.com',
    password: 'Ro@ya_12345',
    confirmPassword: 'Ro@ya_12345',
  );

  try {
    final signupResponse = await api.signUp(signupRequest);
    print('Signup message: ${signupResponse.message}');
  } catch (e) {
    print('Error: $e');
  }

  // Sign in example
  final signinRequest = SigninRequest(
    email: 'rooaya52@gmail.com',
    password: 'Ro@ya_12345',
  );

  try {
    final signinResponse = await api.signIn(signinRequest);
    print('Signin message: ${signinResponse.message}');
    print('Token: ${signinResponse.token}');
  } catch (e) {
    print('Error: $e');
  }
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
        '/create-password': (context) => CreateNewPasswordScreen(),
        '/congrates-page': (context) => CongratulationsScreen(),
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
