// // VerificationCodeEmail.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:marketiapp/core/api/dio_consumer.dart';
// import 'package:marketiapp/core/resources/assets_manager.dart';
// import 'package:marketiapp/features/auth/data/repo/auth_repo.dart';
// import 'package:marketiapp/features/auth/presentation/view/CreatePass/create_new_pass.dart';
// import 'package:marketiapp/features/auth/presentation/vm/VerifyCode/verify_cubit.dart';
// import 'package:marketiapp/features/auth/presentation/vm/VerifyCode/verify_state.dart';

// class VerificationCodeEmail extends StatefulWidget {
//   final String email;
//   const VerificationCodeEmail({super.key, required this.email});

//   @override
//   _VerificationCodeEmailState createState() => _VerificationCodeEmailState();
// }

// class _VerificationCodeEmailState extends State<VerificationCodeEmail> {
//   final List<TextEditingController> _controllers = List.generate(
//     6,
//     (_) => TextEditingController(),
//   );
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   int secondsRemaining = 46;

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
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

//   bool _validateCode() {
//     for (int i = 0; i < _controllers.length; i++) {
//       if (_controllers[i].text.isEmpty) {
//         _showSnackBar(context, 'Please enter all 6 digits');
//         return false;
//       }
//     }
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => VerifyCubit(
//         authRepo: AuthRepo(
//           api: DioConsumer(dio: Dio(), getToken: () async => null),
//         ),
//       ),
//       child: BlocConsumer<VerifyCubit, VerifyState>(
//         listener: (context, state) {
//           if (state is VerifySuccess) {
//             _showSnackBar(context, state.message, isError: false);
            
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CreateNewPasswordScreen(
//                     email: widget.email,
//                   ),
//                 ),
//               );
//             });
//           } else if (state is VerifyFailure) {
//             _showSnackBar(context, state.error);
//           } else if (state is VerifyResendSuccess) {
//             _showSnackBar(context, state.message, isError: false);
//             setState(() => secondsRemaining = 46);
//           } else if (state is VerifyResendFailure) {
//             _showSnackBar(context, state.error);
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is VerifyLoading;
//           final isResending = state is VerifyResendLoading;

//           return Scaffold(
//             appBar: AppBar(
//               leading: const BackButton(color: Colors.black),
//               backgroundColor: Colors.white,
//               elevation: 0,
//               title: const Text(
//                 'Verification Code',
//                 style: TextStyle(color: Colors.black),
//               ),
//               centerTitle: true,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 200,
//                       child: Image.asset(
//                         AppAssets.forgotpassEmail,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Please enter the 6 digit code sent to you: ${widget.email}',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: List.generate(6, (index) {
//                         return SizedBox(
//                           width: 45,
//                           child: TextField(
//                             controller: _controllers[index],
//                             keyboardType: TextInputType.number,
//                             textAlign: TextAlign.center,
//                             maxLength: 1,
//                             style: const TextStyle(fontSize: 24),
//                             decoration: InputDecoration(
//                               counterText: '',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onChanged: (value) {
//                               if (value.length == 1 && index < 5) {
//                                 FocusScope.of(context).nextFocus();
//                               } else if (value.isEmpty && index > 0) {
//                                 FocusScope.of(context).previousFocus();
//                               }
//                             },
//                           ),
//                         );
//                       }),
//                     ),
//                     const SizedBox(height: 30),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: isLoading 
//                             ? null 
//                             : () {
//                                 if (_validateCode()) {
//                                   final verificationCode = _controllers.map((c) => c.text).join();
//                                   context.read<VerifyCubit>().verifyResetCode(
//                                     widget.email,
//                                     verificationCode,
//                                   );
//                                 }
//                               },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                         child: isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : const Text(
//                                 'Verify Code',
//                                 style: TextStyle(fontSize: 16, color: Colors.white),
//                               ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('00:${secondsRemaining.toString().padLeft(2, '0')}'),
//                         const SizedBox(width: 20),
//                         GestureDetector(
//                           onTap: secondsRemaining == 0 && !isResending
//                               ? () {
//                                   context.read<VerifyCubit>().resendVerificationCode(widget.email);
//                                 }
//                               : null,
//                           child: Text(
//                             'Resend Code',
//                             style: TextStyle(
//                               color: secondsRemaining == 0 && !isResending
//                                   ? Colors.blue
//                                   : Colors.grey,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (isResending) const SizedBox(height: 10),
//                     if (isResending) const CircularProgressIndicator(),
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