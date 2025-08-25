import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/helpers/shared_preferences.dart';
import 'package:marketiapp/features/Favorites/data/models/repo/fav_repo.dart';
import 'package:marketiapp/features/Favorites/presentation/vm/Favorite/favorite_cubit.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_brand.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';
import 'package:marketiapp/features/auth/presentation/view/VerificationCode/verify_code_phone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/theme/app_theme.dart';
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
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_details_screen.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';

// Import Favorite Cubit and Repo

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  await CacheHelper.init();

  runApp(MarketiApp());
}

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create Dio instance
    final Dio dio = Dio();

    // Create ApiConsumer with JWT interceptor
    final ApiConsumer apiConsumer = DioConsumer(dio: dio);

    // Create Repos
    final HomeRepo homeRepo = HomeRepo(api: apiConsumer);
    final FavoriteRepo favoriteRepo = FavoriteRepo(api: apiConsumer);

    // Create Cubits
    final HomeCubit homeCubit = HomeCubit(homeRepo: homeRepo);
    final FavoriteCubit favoriteCubit = FavoriteCubit(
      favoriteRepo: favoriteRepo,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        // Provide HomeCubit at the app level
        BlocProvider<HomeCubit>(create: (context) => homeCubit, lazy: false),
        // Provide FavoriteCubit at the app level
        BlocProvider<FavoriteCubit>(
          create: (context) => favoriteCubit,
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Marketi App',
        debugShowCheckedModeBanner: false,
        theme: MarketiTheme.lightTheme,
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
          '/forgot-password-phone': (context) =>
              const ForgotPasswordPhoneScreen(),
          '/create-password': (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            return CreateNewPasswordScreen(
              email: args?['email'] as String? ?? '',
            );
          },
          '/congrates-page': (context) => const CongratulationsScreen(),
          '/home_screen': (context) => const HomeScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/brands': (context) => const BrandsScreen(),
          '/categories': (context) => const CategoryProductScreen(),
          '/popular-products': (context) => const PopularProductScreen(),
          '/product-details': (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            return ProductDetailsScreen(
              id: args?['id'] as String? ?? '',
              name: args?['name'] as String? ?? '',
              imageUrl: args?['imageUrl'] as String? ?? '',
              price: args?['price'] as double? ?? 0.0,
              rating: args?['rating'] as double? ?? 0.0,
              description: args?['description'] as String? ?? '',
            );
          },
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/verification-email':
              final email = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (context) => VerificationCodeScreen(),
              );
            case '/create-password':
              final args = settings.arguments as Map<String, dynamic>?;
              return MaterialPageRoute(
                builder: (context) => CreateNewPasswordScreen(
                  email: args?['email'] as String? ?? '',
                ),
              );
          }
          return null;
        },
      ),
    );
  }
}
