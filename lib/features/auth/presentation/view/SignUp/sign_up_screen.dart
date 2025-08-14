import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/api/end_points.dart';
import 'package:marketiapp/features/auth/data/models/signup_request.dart';
import 'package:marketiapp/features/auth/data/models/signup_response.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  late ApiConsumer _apiConsumer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _apiConsumer = DioConsumer(dio: Dio(), getToken: () async => null);
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blue),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.blue),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  Future<void> _signUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = SignupRequest(
        name: fullNameController.text.trim(),
        username: usernameController.text.trim(), // Added username
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      final response = await _apiConsumer.post(
        EndPoints.signUp,
        data: request.toJson(),
      );

      final signupResponse = SignupResponse.fromJson(response);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(signupResponse.message)));

      Navigator.pushReplacementNamed(
        context,
        '/login',
        arguments: {
          'email': emailController.text.trim(),
          'username': usernameController.text.trim(), // Pass username to login
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup failed: ${e.toString()}')));
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png', height: 170)),
              const SizedBox(height: 20),
              // Full Name Field
              Text('Full Name', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: fullNameController,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your full name'
                    : null,
                decoration: _buildInputDecoration(
                  label: 'Full Name',
                  hint: 'Full Name',
                  icon: Icons.person,
                ),
              ),
              const SizedBox(height: 16),
              // Username Field (NEW)
              Text('Username', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: usernameController,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a username'
                    : value.length < 3
                    ? 'Username must be at least 3 characters'
                    : null,
                decoration: _buildInputDecoration(
                  label: 'Username',
                  hint: '@username',
                  icon: Icons.alternate_email,
                ),
              ),
              const SizedBox(height: 16),
              // Phone Number Field
              Text('Phone Number', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your phone number'
                    : null,
                decoration: _buildInputDecoration(
                  label: 'Phone Number',
                  hint: '+20 1501142409',
                  icon: Icons.phone_android,
                ),
              ),
              const SizedBox(height: 16),
              // Email Field
              Text('Email', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your email'
                    : null,
                decoration: _buildInputDecoration(
                  label: 'Email',
                  hint: 'You@gmail.com',
                  icon: Icons.email,
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              Text('Password', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a password'
                    : value.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                decoration: _buildInputDecoration(
                  label: 'Password',
                  hint: '***********',
                  icon: Icons.lock,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password Field
              Text('Confirm Password', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: _buildInputDecoration(
                  label: 'Confirm Password',
                  hint: '***********',
                  icon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '© Continue with',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
