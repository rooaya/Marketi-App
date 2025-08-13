import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/api_interceptors.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  _ForgotPasswordEmailScreenState createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailEmpty = false;
  bool _isLoading = false;
  late ApiConsumer _apiConsumer;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    dio.interceptors.add(ApiInterceptors());
    _apiConsumer = ApiConsumer(dio: dio);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _onSendCode() async {
    final email = _emailController.text.trim();

    setState(() {
      _isEmailEmpty = email.isEmpty;
    });

    // Simple email validation pattern
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regex = RegExp(emailPattern);

    if (_isEmailEmpty) {
      _showErrorMessage('Please enter your email address');
      return;
    } else if (!regex.hasMatch(email)) {
      _showErrorMessage('Please enter a valid email address');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiConsumer.dio.post(
        '${EndPoints.baseUrl}${EndPoints.resetpass}',
        data: {'email': email},
        options: Options(
          validateStatus: (status) =>
              status! < 500, // Don't throw for 400 errors
        ),
      );

      if (response.statusCode == 200) {
        _showSuccessMessage('Verification code sent successfully!');
        Navigator.pushNamed(
          context,
          '/verification-email',
          arguments: {'email': email},
        );
      } else if (response.statusCode == 400) {
        // Handle specific error messages from server
        final errorMessage =
            response.data['message']?.toString() ??
            'Invalid request. Please check your email and try again.';

        if (errorMessage.toLowerCase().contains('not verified')) {
          _showErrorMessage(
            'Please verify your email first. Check your inbox for verification link.',
          );
        } else {
          _showErrorMessage(errorMessage);
        }
      } else {
        _showErrorMessage(
          'Failed to send verification code. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle Dio errors with response
        final errorData = e.response?.data;
        final errorMessage = errorData is Map
            ? errorData['message']?.toString() ??
                  'Failed to send verification code'
            : 'Failed to send verification code';

        if (errorMessage.toLowerCase().contains('not verified')) {
          _showErrorMessage(
            'Please verify your email first. Check your inbox for verification link.',
          );
        } else {
          _showErrorMessage(errorMessage);
        }
      } else {
        // Handle Dio errors without response
        _showErrorMessage('Network error: ${e.message}');
      }
    } catch (e) {
      _showErrorMessage('An unexpected error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                AppAssets.forgotpassEmail,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Please enter your email address to receive a verification code',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email, color: Colors.blue),
                labelText: 'Email',
                hintText: 'You@gmail.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                errorText: _isEmailEmpty ? 'This field is required' : null,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _onSendCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Send Code',
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
