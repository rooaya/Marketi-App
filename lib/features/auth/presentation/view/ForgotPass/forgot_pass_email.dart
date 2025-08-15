import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/core/helpers/validetor.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/auth/data/models/reset_password_response.dart';
import 'package:marketiapp/features/auth/presentation/view/VerificationCode/verify_code_email.dart';

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

  Future<void> _sendResetCode() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiConsumer.post(
        EndPoints.resetpass,
        data: {'email': _emailController.text.trim()},
      );

      print('API Response: $response');
      final resetResponse = ResetPasswordResponse.fromJson(response);
      
      if (resetResponse.success) {
        if (!mounted) return;
        
        // GUARANTEED NAVIGATION SOLUTION
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationCodeEmail(
                email: _emailController.text.trim(),
              ),
            ),
          );
        });
      } else {
        _showSnackBar(resetResponse.message ?? 'Failed to send verification code');
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.response?.data}');
      if (e.response?.data?['message']?.toString().toLowerCase().contains('not verify') == true) {
        _showUnverifiedEmailDialog();
      } else {
        _showSnackBar(
          e.response?.data?['message']?.toString() ?? 
          e.message ?? 
          'Network error occurred',
        );
      }
    } catch (e) {
      print('Error: $e');
      _showSnackBar('An unexpected error occurred: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
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
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Image.asset(AppAssets.forgotpassEmail, height: 300, width: 300),
              const SizedBox(height: 16),
              Text(
                'Please enter your email address to receive a verification code',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                validator: TValidator.validateEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'You@gmail.com',
                  prefixIcon: Icon(Icons.email, color: Colors.blue[300]),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _sendResetCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Send Code',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}