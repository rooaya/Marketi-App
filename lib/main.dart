import 'package:flutter/material.dart';
import 'package:marketiapp/core/helpers/shared_preferences.dart';
import 'package:marketiapp/marketi_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  runApp(MarketiApp());
}
