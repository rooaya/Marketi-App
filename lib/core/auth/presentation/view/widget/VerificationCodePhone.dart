import 'package:flutter/material.dart';
import 'dart:async';

import 'package:marketiapp/core/resources/assets_manager.dart';

class VerificationCodeScreen extends StatefulWidget {
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();

  Timer? _timer;
  int _start = 46;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 46;
    _timer?.cancel();
    setState(() {}); // to update UI immediately
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {}); // update UI when timer ends
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _digit1Controller.dispose();
    _digit2Controller.dispose();
    _digit3Controller.dispose();
    _digit4Controller.dispose();
    super.dispose();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _onVerify() {
    if (_digit1Controller.text.isEmpty ||
        _digit2Controller.text.isEmpty ||
        _digit3Controller.text.isEmpty ||
        _digit4Controller.text.isEmpty) {
      _showErrorMessage('Please enter all 4 digits');
      return;
    }
    // Proceed to next screen
    Navigator.pushNamed(context, '/create-password');
  }

  Widget buildDigitBox(TextEditingController controller) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(counterText: '', border: InputBorder.none),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String timerText = '00:${_start.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Verification Code', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Illustration Image
            Expanded(
              child: Center(
                child: Image.asset(AppAssets.verificationcode, height: 200),
              ),
            ),
            Text(
              'Please enter the 4 digit code sent to you: +20 1501142409',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 116, 112, 112),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            // Digit input boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDigitBox(_digit1Controller),
                buildDigitBox(_digit2Controller),
                buildDigitBox(_digit3Controller),
                buildDigitBox(_digit4Controller),
              ],
            ),
            SizedBox(height: 30),
            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onVerify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
                Text(timerText),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: _start == 0
                      ? () {
                          startTimer(); // restart timer on click
                        }
                      : null,
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: _start == 0 ? Colors.blue : Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
