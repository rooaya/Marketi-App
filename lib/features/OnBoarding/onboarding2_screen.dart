import 'package:flutter/material.dart';
import 'package:marketiapp/core/theme/app_size.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/theme/style_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';
class OnboardingPage2 extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;

  const OnboardingPage2({
    super.key,
    required this.onNextPressed,
    required this.onBackPressed, required void Function() onSkipPressed,
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
                ),
              ),
              Expanded(
                child: Image.asset(
                  AppAssets.onboarding2,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'Easy to Buy',
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
                  'Find the perfect item that suits your style and needs. With secure payment options and fast delivery, shopping has never been easier.',
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
                  onPressed: onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MarketiColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSize.paddingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.buttonRadius),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: AppTextStyles.labelLarge,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(false),
                  const SizedBox(width: AppSize.paddingSmall),
                  _buildPageIndicator(true),
                  const SizedBox(width: AppSize.paddingSmall),
                  _buildPageIndicator(false),
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
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? MarketiColors.primaryBlue : MarketiColors.gray300,
        borderRadius: BorderRadius.circular(AppSize.radiusDefault),
      ),
    );
  }
}