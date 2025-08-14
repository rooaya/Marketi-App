import 'package:flutter/material.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  int _selectedRating = 0;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8), // Space for shadow
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: AppBar(
              backgroundColor: MarketiColors.infoLight,
              title: const Text(
                'Rate Us',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0, // Remove default shadow
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How would you rate us?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(AppAssets.logo, width: 200, height: 200),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _selectedRating ? Icons.star : Icons.star_border,
                    size: 50,
                    color: MarketiColors.primaryBlue,
                  ),
                );
              }),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: MarketiColors.primaryBlue),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: MarketiColors.primaryBlue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedRating == 0 || _isSubmitting
                        ? null
                        : () async {
                            setState(() => _isSubmitting = true);
                            // Submit rating logic here
                            await Future.delayed(const Duration(seconds: 1));
                            setState(() => _isSubmitting = false);
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MarketiColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'OK',
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
