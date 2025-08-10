import 'package:flutter/material.dart';

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

  final _formKey = GlobalKey<FormState>();

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

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // Implement your sign-up logic here
      print('Full Name: ${fullNameController.text}');
      print('Username: ${usernameController.text}');
      print('Phone: ${phoneController.text}');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
      print('Confirm Password: ${confirmPasswordController.text}');

      // Navigate to home or another screen
      Navigator.pushReplacementNamed(context, '/home');
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
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo placeholder
              Center(child: Image.asset('assets/images/logo.png', height: 170)),
              const SizedBox(height: 20),
              // Full Name
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
              // Username
              Text('Username', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: usernameController,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a username'
                    : null,
                decoration: _buildInputDecoration(
                  label: 'Username',
                  hint: 'Name name',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: 16),
              // Phone
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
              // Email
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
              // Password
              Text('Password', style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter a password'
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
              // Confirm Password
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
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Footer Text
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
