import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/api_interceptors.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/models/reset_password_response.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;
  final String resetCode;

  const CreateNewPasswordScreen({
    super.key,
    required this.email,
    required this.resetCode,
  });

  @override
  _CreateNewPasswordScreenState createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordEmpty = false;
  bool _isConfirmPasswordEmpty = false;
  bool _isLoading = false;
  late ApiConsumer apiConsumer;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    dio.interceptors.add(ApiInterceptors());
    apiConsumer = ApiConsumer(dio: dio);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _resetPassword() async {
    final newPass = _passwordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    setState(() {
      _isPasswordEmpty = newPass.isEmpty;
      _isConfirmPasswordEmpty = confirmPass.isEmpty;
    });

    if (_isPasswordEmpty || _isConfirmPasswordEmpty) {
      _showErrorMessage('Please fill in all fields');
      return;
    }

    if (newPass != confirmPass) {
      _showErrorMessage('Passwords do not match');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await apiConsumer.dio.post(
        '${EndPoints.baseUrl}${EndPoints.resetPass}',
        data: {
          'email': widget.email,
          'newPassword': newPass,
          'resetCode': widget.resetCode,
        },
      );

      if (response.statusCode == 200) {
        final resetResponse = ResetPasswordResponse.fromJson(response.data);
        if (resetResponse.success) {
          _showSuccessMessage('Password reset successfully!');
          Navigator.pushNamed(context, '/congrates-page');
        } else {
          _showErrorMessage(resetResponse.message ?? 'Password reset failed');
        }
      } else {
        _showErrorMessage('Password reset failed: ${response.data}');
      }
    } catch (e) {
      _showErrorMessage('Error resetting password: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create New Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset(AppAssets.createnewpass),
            SizedBox(height: 20),
            Text(
              'New password must be different from last password',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: _isPasswordEmpty ? 'This field is required' : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: _isConfirmPasswordEmpty ? 'This field is required' : null,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Save Password',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}