import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/theme/app_theme.dart';
import 'package:marketiapp/features/Cart/data/repo/cart_repo.dart';
import 'package:marketiapp/features/Cart/presentation/vm/Cart/cart_cubit.dart';
import 'package:marketiapp/features/Congratulations/presentation/view/congratulation_screen.dart';
import 'package:marketiapp/features/Favorites/data/models/repo/fav_repo.dart';
import 'package:marketiapp/features/Favorites/presentation/vm/Favorite/favorite_cubit.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/home_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_brand.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_category.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_details_screen.dart';
import 'package:marketiapp/features/Home/presentation/vm/home/brand_cubit.dart';
import 'package:marketiapp/features/Home/presentation/vm/home/category_cubit.dart';
import 'package:marketiapp/features/Home/presentation/vm/home/product_cubit.dart';
import 'package:marketiapp/features/OnBoarding/onboarding1_screen.dart';
import 'package:marketiapp/features/OnBoarding/onboarding2_screen.dart';
import 'package:marketiapp/features/OnBoarding/onboarding3_screen.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';
import 'package:marketiapp/features/auth/presentation/view/CreatePass/create_new_pass.dart';
import 'package:marketiapp/features/auth/presentation/view/ForgotPass/forgot_pass.dart';
import 'package:marketiapp/features/auth/presentation/view/Login/login_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/SignUp/sign_up_screen.dart';
import 'package:marketiapp/features/auth/presentation/vm/ForgotPass/forgot_pass_cubit.dart';
import 'package:marketiapp/features/auth/presentation/vm/SignUp/sign_up_cubit.dart';
import 'package:marketiapp/features/auth/presentation/vm/createpass/createpass_cubit.dart';
import 'package:marketiapp/features/auth/presentation/vm/login/login_cubit.dart';
import 'package:marketiapp/features/favorites/presentation/view/favourite/favourites_screen.dart';
import 'package:marketiapp/features/splash/presentation/view/splash_screen.dart';

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final ApiConsumer apiConsumer = DioConsumer(dio: dio);
    final HomeRepo homeRepo = HomeRepo(api: apiConsumer);
    final FavoriteRepo favoriteRepo = FavoriteRepo(api: apiConsumer);
    final CartRepo cartRepo = CartRepo(api: apiConsumer);
    final AuthRepo authRepo = AuthRepo(api: apiConsumer);

    return MaterialApp(
      title: 'Marketi App',
      debugShowCheckedModeBanner: false,
      theme: MarketiTheme.lightTheme,
      // Use home instead of initialRoute to avoid routing issues
      home: const SplashScreen(),
      routes: {
        '/onboarding1': (context) => OnboardingPage1(
              onNextPressed: () => Navigator.pushReplacementNamed(context, '/onboarding2'),
              onSkipPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
        '/onboarding2': (context) => OnboardingPage2(
              onNextPressed: () => Navigator.pushReplacementNamed(context, '/onboarding3'),
              onBackPressed: () => Navigator.pop(context),
              onSkipPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
        '/onboarding3': (context) => OnboardingPage3(
              onGetStartedPressed: () => Navigator.pushReplacementNamed(context, '/login'),
              onBackPressed: () => Navigator.pop(context),
            ),
        '/sign-up': (context) => BlocProvider(
              create: (context) => SignUpCubit(authRepo: authRepo),
              child: const SignUpScreen(),
            ),
        '/login': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return BlocProvider(
            create: (context) => LoginCubit(authRepo: authRepo),
            child: LoginScreen(
              onLoginSuccess: () => Navigator.pushReplacementNamed(context, '/home_screen'),
              initialEmail: args?['email']?.toString(),
            ),
          );
        },
        '/forgot-password-phone': (context) => BlocProvider(
              create: (context) => ForgotPassCubit(authRepo: authRepo), //TODO: No_send_code_btn_work_with api
              child: const ForgotPasswordPhoneScreen(),
            ),
        '/create-password': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return BlocProvider(
            create: (context) => CreatepassCubit(authRepo: authRepo, email: args?['email'] as String? ?? ''),
            child: CreateNewPasswordScreen(
              email: args?['email'] as String? ?? '',
            ),
          );
        },
        '/congrates-page': (context) => const CongratulationsScreen(),
        '/home_screen': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<ProductCubit>(create: (context) => ProductCubit(homeRepo: homeRepo)..getProducts()),
                BlocProvider<BrandCubit>(create: (context) => BrandCubit(homeRepo: homeRepo)..getBrands()),
                BlocProvider<CategoryCubit>(create: (context) => CategoryCubit(homeRepo: homeRepo)..getCategories()),
                BlocProvider<FavoriteCubit>(create: (context) => FavoriteCubit(favoriteRepo: favoriteRepo)),
                BlocProvider<CartCubit>(create: (context) => CartCubit(cartRepo: cartRepo)),
                /*
                      PopularProductsCubit
                      ProductsByBrandCubit
                      ProductsByCategoryCubit
                 */
              ],
              child: const HomeScreen(),
            ),
        '/favorites': (context) => BlocProvider(
              create: (context) => FavoriteCubit(favoriteRepo: favoriteRepo)..getFavorites(),
              child: const FavoritesScreen(),
            ),
        '/profile': (context) => const ProfileScreen(),
        '/brands': (context) => const BrandsScreen(),
        '/categories': (context) => const CategoryProductScreen(),
        '/popular-products': (context) => const PopularProductScreen(),
        '/products-by-category': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProductsByCategoryScreen(
            categoryName: args?['categoryName'] as String? ?? '',
          );
        },
        '/products-by-brand': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProductsByBrandScreen(
            brandName: args?['brandName'] as String? ?? '',
          );
        },
        '/product-details': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
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
    );
  }
}
