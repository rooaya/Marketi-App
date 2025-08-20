import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/theme/app_theme.dart';
import 'package:marketiapp/features/vm/user_cubit.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_provider.dart';
import 'package:marketiapp/features/Congratulations/presentation/view/congratulation_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/CreatePass/create_new_pass.dart';
import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_provider.dart';
import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/ForgotPass/forgot_pass.dart';
import 'package:marketiapp/features/auth/presentation/view/ForgotPass/forgot_pass_email.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/home_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/Login/login_screen.dart';
import 'package:marketiapp/features/OnBoarding/onboarding1_screen.dart';
import 'package:marketiapp/features/OnBoarding/onboarding2_screen.dart';
import 'package:marketiapp/features/OnBoarding/onboarding3_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/SignUp/sign_up_screen.dart';
import 'package:marketiapp/features/splash/presentation/view/splash_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/VerificationCode/verify_code_email.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MarketiApp());
}

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  // This function will be used to get the token
  Future<String?> _getToken() async {
    // Implement your token retrieval logic here
    // For example, from shared preferences or secure storage
    return null; // Return null if no token is available
  }

  @override
  Widget build(BuildContext context) {
    // Create Dio instance
    final Dio dio = Dio();

    // Create ApiConsumer with the required getToken function
    final ApiConsumer apiConsumer = DioConsumer(
      dio: dio, // Pass the token retrieval function
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        BlocProvider(create: (context) => UserCubit(apiConsumer: apiConsumer)),
      ],
      child: MaterialApp(
        title: 'Marketi App',
        debugShowCheckedModeBanner: false,
        theme: MarketiTheme.lightTheme,//TODO: themeCubit
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
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            return LoginScreen(
              onLoginSuccess: () =>
                  Navigator.pushReplacementNamed(context, '/home_screen'),
              initialEmail: args?['email']?.toString(),
            );
          },
          '/forgot-password-phone': (context) => ForgotPasswordPhoneScreen(),
          '/forgot-password-email': (context) => ForgotPasswordEmailScreen(),
          '/verification-email': (context) {
            final email = ModalRoute.of(context)!.settings.arguments as String;
            print('Route /verification-email created with email: $email');
            return VerificationCodeEmail(email: email);
          },
          '/create-password': (context) {
            final args =
                ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>;
            print('Route /create-password created with args: $args');
            return CreateNewPasswordScreen(email: args['email'] as String);
          },
          '/congrates-page': (context) => CongratulationsScreen(),
          '/home_screen': (context) => HomeScreen(),
          '/favorites': (context) => const FavoritesScreen(),
        },
      ),
    );
  }
}
