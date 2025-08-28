import 'package:flutter/material.dart';

class NavigationHelper {
  /// Safely navigates to a new screen
  static void navigateTo(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    });
  }

  /// Safely navigates and replaces current screen
  static void navigateReplacement(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    });
  }

  /// Safely navigates to a new screen and removes all previous screens
  static void navigateAndRemoveAll(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => page),
          (route) => false,
        );
      }
    });
  }

  /// Safely goes back to the previous screen
  static void navigateBack(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }
}