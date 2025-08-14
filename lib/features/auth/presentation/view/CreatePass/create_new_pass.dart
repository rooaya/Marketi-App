import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/core/helpers/validetor.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/auth/data/models/reset_password_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late ApiConsumer _apiConsumer;

  @override
  void initState() {
    super.initState();
    _apiConsumer = DioConsumer(
      dio: Dio(),
      getToken: () async => null,
    );
  }

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _apiConsumer.post(
        EndPoints.resetPass,
        data: {
          'email': widget.email,
          'newPassword': _passwordController.text.trim(),
          'resetCode': widget.resetCode,
        },
      );

      final resetResponse = ResetPasswordResponse.fromJson(response);
      if (resetResponse.success) {
        _showMessage('Password updated successfully!', isError: false);
        
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getBool('isLoggedIn') == true && 
            prefs.getString('email') == widget.email) {
          await prefs.setString('savedPassword', _passwordController.text.trim());
        }
        
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        _showMessage(resetResponse.message ?? 'Password update failed');
      }
    } catch (e) {
      _showMessage('Error updating password: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create New Password'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(AppAssets.createnewpass),
              const SizedBox(height: 20),
              Text(
                'New password must be different from last password',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: TValidator.validatePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) => TValidator.validateEmptyText('Confirm Password', value),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_reset),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Save Password',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}