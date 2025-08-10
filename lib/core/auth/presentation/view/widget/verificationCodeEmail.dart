import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';

class VerificationCodeEmail extends StatefulWidget {
  @override
  _VerificationCodeEmailState createState() => _VerificationCodeEmailState();
}

class _VerificationCodeEmailState extends State<VerificationCodeEmail> {
  // Controllers for each input box
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  // Timer duration
  int secondsRemaining = 46;
  Ticker? _ticker; // Make nullable

  @override
  void initState() {
    super.initState();
    startTimer(); // Start timer on init
  }

  // Function to start or restart the timer
  void startTimer() {
    _ticker?.dispose(); // Dispose previous ticker if any
    _ticker = Ticker((elapsed) {
      final newSeconds = 46 - elapsed.inSeconds;
      if (newSeconds > 0) {
        setState(() {
          secondsRemaining = newSeconds;
        });
      } else {
        setState(() {
          secondsRemaining = 0;
        });
        _ticker?.stop();
      }
    });
    _ticker?.start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _onVerify() {
    // Check if all fields are filled
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.isEmpty) {
        _showErrorMessage('Please enter all 4 digits');
        return;
      }
    }

    // Optional: You can add further validation for the code here

    // Proceed to next screen
    Navigator.pushNamed(context, '/create-password');
  }

  // Function to handle resend code
  void _resendCode() {
    setState(() {
      secondsRemaining = 46;
    });
    startTimer();
    // Add your resend code logic here, e.g., API call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Verification Code', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Illustration Image
            Container(
              height: 200,
              child: Image.asset(
                AppAssets.forgotpassEmail, // replace with your asset path
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please enter the 4 digit code sent to you: you@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            // Input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 30),
            // Verify Code Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onVerify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Verify Code',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Timer and Resend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('00:${secondsRemaining.toString().padLeft(2, '0')}'),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: secondsRemaining == 0 ? _resendCode : null,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: secondsRemaining == 0 ? Colors.blue : Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}