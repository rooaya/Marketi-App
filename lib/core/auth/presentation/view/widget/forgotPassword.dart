import 'package:flutter/material.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';

class ForgotPasswordPhoneScreen extends StatefulWidget {
  const ForgotPasswordPhoneScreen({super.key});

  @override
  _ForgotPasswordPhoneScreenState createState() =>
      _ForgotPasswordPhoneScreenState();
}

class _ForgotPasswordPhoneScreenState extends State<ForgotPasswordPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isPhoneEmpty = false;
  String _selectedCountryCode = '+20';
  bool _isNumberTyped = false; // Track if user typed a number
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  final List<Map<String, String>> countryCodes = [
    {'code': '+20', 'name': 'Egypt'},
    {'code': '+966', 'name': 'Saudi Arabia'},
    {'code': '+971', 'name': 'UAE'},
    {'code': '+44', 'name': 'UK'},
    {'code': '+1', 'name': 'USA'},
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });
    _phoneController.addListener(() {
      // Update _isNumberTyped based on whether there's text
      setState(() {
        _isNumberTyped = _phoneController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    _removeOverlay(); // Remove overlay if any
    super.dispose();
  }

  // Define _removeOverlay() to remove overlay if exists
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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

  void _onSendCode() {
    final phone = _phoneController.text.trim();
    setState(() => _isPhoneEmpty = phone.isEmpty);
    if (_isPhoneEmpty) {
      _showErrorMessage('Please enter your phone number');
      return;
    }
    Navigator.pushNamed(context, '/verification-phone');
  }

  void _showCountryCodeOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: countryCodes.map((country) {
          return ListTile(
            title: Text('${country['name']} (${country['code']})'),
            onTap: () {
              setState(() => _selectedCountryCode = country['code']!);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Forgot Password', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppAssets.forgotPassphon,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please enter your phone number to receive a verification code',
              style: TextStyle(
                color: const Color.fromARGB(255, 105, 97, 97),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              focusNode: _focusNode,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                color: _isNumberTyped ? Colors.black : Colors.grey,
              ),
              decoration: InputDecoration(
                hintText: '1501142409',
                fillColor: const Color.fromARGB(255, 236, 231, 231),
                prefixIcon: Icon(Icons.phone_android, color: Colors.blue),
                suffix: GestureDetector(
                  onTap: _showCountryCodeOptions,
                  child: Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedCountryCode,
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                errorText: _isPhoneEmpty ? 'This field is required' : null,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onSendCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Send Code',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password-email');
              },
              child: Text(
                'Try Another Way',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}