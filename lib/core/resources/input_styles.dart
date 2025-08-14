import 'package:flutter/material.dart';
import 'package:marketiapp/core/theme/app_size.dart';
import 'package:marketiapp/core/theme/app_colors.dart';

class InputStyles {
  static InputDecoration textField({
    required BuildContext context,
    String? label,
    String? hint,
    Widget? prefix,
    Widget? suffix,
    bool hasError = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefix,
      suffixIcon: suffix,
      filled: true,
      fillColor: MarketiColors.white,
      contentPadding: const EdgeInsets.all(AppSize.paddingMedium),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: BorderSide(
          color: hasError ? MarketiColors.error : MarketiColors.gray300,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: const BorderSide(
          color: MarketiColors.gray300,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: const BorderSide(
          color: MarketiColors.primaryRed,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
        borderSide: const BorderSide(
          color: MarketiColors.error,
          width: AppSize.inputFieldBorderWidth,
        ),
      ),
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MarketiColors.gray500,
          ),
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MarketiColors.gray400,
          ),
    );
  }

  static InputDecoration searchField(BuildContext context) {
    return textField(
      context: context,
      hint: 'Search products...',
      prefix: const Icon(Icons.search, size: AppSize.iconMedium),
    ).copyWith(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSize.paddingSmall,
        horizontal: AppSize.paddingMedium,
      ),
    );
  }
}