import 'package:flutter/material.dart';
import 'package:marketiapp/core/resources/app_size.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/resources/style_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';

class OnboardingPage3 extends StatelessWidget {
  final VoidCallback onGetStartedPressed;
  final VoidCallback onBackPressed;

  const OnboardingPage3({
    super.key,
    required this.onGetStartedPressed,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MarketiColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.paddingExtraLarge),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onBackPressed,
                  color: MarketiColors.textPrimary, // Added for consistency
                ),
              ),
              Expanded(
                child: Image.asset(
                  AppAssets.onboarding3, 
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'Wonderful User Experience',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.paddingMedium),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingLarge,
                ),
                child: Text(
                  'Start exploring now and experience the convenience of online shopping at its best.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: MarketiColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSize.paddingExtraLarge),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to login screen and remove all previous routes
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login', // Make sure this route is defined in your app
                      (route) => false, // This removes all previous routes
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MarketiColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.paddingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.buttonRadius),
                    ),
                    elevation: 0, // Added for better visual
                  ),
                  child: Text(
                    'Get Started!', 
                    style: AppTextStyles.labelLarge.copyWith(
                      color: MarketiColors.white, // Ensure text is visible
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(false),
                  const SizedBox(width: AppSize.paddingSmall),
                  _buildPageIndicator(false),
                  const SizedBox(width: AppSize.paddingSmall),
                  _buildPageIndicator(true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? MarketiColors.primaryBlue : MarketiColors.gray300,
        borderRadius: BorderRadius.circular(AppSize.radiusDefault),
      ),
    );
  }
}