// lib/helpers/safe_context.dart
import 'package:flutter/material.dart';

extension SafeContext on BuildContext {
  /// Safely navigates to a new screen
  void safeNavigate(Widget page) {
    if (mounted) {
      Navigator.of(this).push(
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  /// Safely navigates and replaces current screen
  void safeReplace(Widget page) {
    if (mounted) {
      Navigator.of(this).pushReplacement(
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  /// Safely pops the current screen
  void safePop() {
    if (mounted) {
      Navigator.of(this).pop();
    }
  }

  /// Safely navigates to a new screen and removes all previous screens
  void safeNavigateAndRemoveAll(Widget page) {
    if (mounted) {
      Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );
    }
  }

  /// Safely shows a dialog
  void safeShowDialog(Widget dialog) {
    if (mounted) {
      showDialog(
        context: this,
        builder: (context) => dialog,
      );
    }
  }

  /// Safely shows a bottom sheet
  void safeShowBottomSheet(Widget bottomSheet) {
    if (mounted) {
      showModalBottomSheet(
        context: this,
        builder: (context) => bottomSheet,
      );
    }
  }
}