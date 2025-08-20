// // forgot_password_email_screen.dart (modified to use Cubit)
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:marketiapp/core/api/dio_consumer.dart';
// import 'package:marketiapp/core/helpers/validetor.dart';
// import 'package:marketiapp/core/resources/assets_manager.dart';
// import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';

// import 'package:marketiapp/features/auth/presentation/view/VerificationCode/verify_code_email.dart';
// import 'package:marketiapp/features/auth/presentation/vm/ForgotPass/forgot_pass_cubit.dart';

// class ForgotPasswordEmailScreen extends StatefulWidget {
//   const ForgotPasswordEmailScreen({super.key});

//   @override
//   State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
// }

// class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }

//   void _showSnackBar(BuildContext context, String message, {bool isError = true}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void _showUnverifiedEmailDialog(BuildContext context, String email) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Email Not Verified'),
//         content: const Text('Please verify your email before resetting your password.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               context.read<ForgotPassCubit>().resendVerificationEmail(email);
//             },
//             child: const Text('Resend Verification'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ForgotPassCubit(
//         authRepo: AuthRepo(
//           api: DioConsumer(dio: Dio()),
//         ),
//       ),
//       child: BlocConsumer<ForgotPassCubit, ForgotPassState>(
//         listener: (context, state) {
//           if (state is ForgotPassSuccess) {
//             _showSnackBar(context, state.resetResponse.message ?? 'Verification code sent!', isError: false);
            
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => VerificationCodeEmail(
//                     email: _emailController.text.trim(),
//                   ),
//                 ),
//               );
//             });
//           } else if (state is ForgotPassFailure) {
//             if (state.error.toLowerCase().contains('not verify')) {
//               _showUnverifiedEmailDialog(context, _emailController.text.trim());
//             } else {
//               _showSnackBar(context, state.error);
//             }
//           } else if (state is ForgotPassResendSuccess) {
//             _showSnackBar(context, 'Verification email sent!', isError: false);
//           } else if (state is ForgotPassResendFailure) {
//             _showSnackBar(context, state.error);
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is ForgotPassLoading;
          
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             body: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 40),
//                     Image.asset(AppAssets.forgotpassEmail, height: 300, width: 300),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Please enter your email address to receive a verification code',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 40),
//                     TextFormField(
//                       controller: _emailController,
//                       validator: TValidator.validateEmail,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         hintText: 'You@gmail.com',
//                         prefixIcon: Icon(Icons.email, color: Colors.blue[300]),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue[300]!),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue[300]!),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//                     ElevatedButton(
//                       onPressed: isLoading 
//                           ? null 
//                           : () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<ForgotPassCubit>().sendResetCode(
//                                   _emailController.text.trim(),
//                                 );
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               'Send Code',
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }