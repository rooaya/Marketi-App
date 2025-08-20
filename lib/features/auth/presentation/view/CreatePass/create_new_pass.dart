// create_new_pass_screen.dart (modified)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:marketiapp/core/api/dio_consumer.dart';
import 'package:marketiapp/core/helpers/validetor.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';
import 'package:marketiapp/features/auth/presentation/vm/createpass/createpass_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;

  const CreateNewPasswordScreen({super.key, required this.email});

  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showMessage(BuildContext context, String message, {bool isError = true}) {
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

  Future<void> _updateSavedPassword() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') == true &&
        prefs.getString('email') == widget.email) {
      await prefs.setString(
        'savedPassword',
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatepassCubit(
        authRepo: AuthRepo(
          api: DioConsumer(dio: Dio()), // Fixed constructor
        ),
        email: widget.email,
      ),
      child: BlocConsumer<CreatepassCubit, CreatepassState>(
        listener: (context, state) {
          if (state is CreatepassSuccess) {
            _updateSavedPassword();
            _showMessage(context, 'Password updated successfully!', isError: false);
            Navigator.pushReplacementNamed(context, '/congrates-page');
          } else if (state is CreatepassFailure) {
            _showMessage(context, state.error);
          }
        },
        builder: (context, state) {
          final isLoading = state is CreatepassLoading;
          
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
                      validator: (value) =>
                          TValidator.validateEmptyText('Confirm Password', value),
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
                        onPressed: isLoading ? null : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<CreatepassCubit>().resetPassword(
                              newPassword: _passwordController.text.trim(),
                              confirmPassword: _confirmPasswordController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: isLoading
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
        },
      ),
    );
  }
}