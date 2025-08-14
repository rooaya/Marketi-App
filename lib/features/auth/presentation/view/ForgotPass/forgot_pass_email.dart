import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/core/helpers/validetor.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late ApiConsumer _apiConsumer;

  @override
  void initState() {
    super.initState();
    _apiConsumer = DioConsumer(dio: Dio(), getToken: () async => null);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleSendResetCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiConsumer.post(
        EndPoints.resetpass,
        data: {'email': _emailController.text.trim()},
      );

      if (response['success'] == true) {
        Navigator.pushNamed(
          context,
          '/reset-password',
          arguments: {'email': _emailController.text.trim()},
        );
      }
    } on DioError catch (e) {
      // Handle specific unverified email case
      if (e.response?.data?['message']?.toString().toLowerCase().contains('not verify') == true) {
        _showUnverifiedEmailDialog();
      } else {
        _showSnackBar(e.response?.data?['message']?.toString() ?? 'Request failed');
      }
    } catch (e) {
      _showSnackBar('An error occurred');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showUnverifiedEmailDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Email Not Verified'),
        content: const Text('Please verify your email before resetting your password.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resendVerificationEmail();
            },
            child: const Text('Resend Verification'),
          ),
        ],
      ),
    );
  }

  Future<void> _resendVerificationEmail() async {
    setState(() => _isLoading = true);
    try {
      await _apiConsumer.post(
        '${EndPoints.baseUrl}/auth/resend-verification',
        data: {'email': _emailController.text.trim()},
      );
      _showSnackBar('Verification email sent!', isError: false);
    } catch (e) {
      _showSnackBar('Failed to resend verification email');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.forgotpassEmail, height: 200),
              const SizedBox(height: 24),
              Text(
                'Enter your email to receive a password reset link',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSendResetCode,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Send Reset Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}