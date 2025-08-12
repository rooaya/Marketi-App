import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';

class VerificationCodeEmail extends StatefulWidget {
  @override
  _VerificationCodeEmailState createState() => _VerificationCodeEmailState();
}

class _VerificationCodeEmailState extends State<VerificationCodeEmail> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  int secondsRemaining = 46;
  Ticker? _ticker; 

  @override
  void initState() {
    super.initState();
    startTimer(); 
  }

  void startTimer() {
    _ticker?.dispose(); 
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


    // Proceed to next screen
    Navigator.pushNamed(context, '/create-password');
  }

  void _resendCode() {
    setState(() {
      secondsRemaining = 46;
    });
    startTimer();
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
            Container(
              height: 200,
              child: Image.asset(
                AppAssets.forgotpassEmail,
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