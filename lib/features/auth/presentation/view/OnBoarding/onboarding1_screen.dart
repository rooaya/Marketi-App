import 'package:flutter/material.dart';
import 'package:marketiapp/core/theme/app_size.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/theme/style_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';
import 'package:marketiapp/core/resources/input_styles.dart';

class OnboardingPage1 extends StatelessWidget {
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;

  const OnboardingPage1({
    super.key,
    required this.onNextPressed,
    required this.onSkipPressed,
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
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: onSkipPressed,
                  child: Text(
                    'Skip',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: MarketiColors.primaryBlue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(AppAssets.onboarding1, fit: BoxFit.contain),
              ),
              Text(
                'Welcome to Marketi!',
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
                  'Discover a world of endless possibilities and shop from the comfort of your fingertips! Browse through a wide range of products, from fashion and electronics to home.',
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
                  child: Text('Next', style: AppTextStyles.labelLarge),
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(true),
                  const SizedBox(width: AppSize.paddingSmall),
                  _buildPageIndicator(false),
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
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? MarketiColors.primaryBlue : MarketiColors.gray300,
        borderRadius: BorderRadius.circular(AppSize.radiusDefault),
      ),
    );
  }
}
