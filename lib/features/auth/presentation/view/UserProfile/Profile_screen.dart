import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/core/theme/app_colors.dart';
import 'package:marketiapp/features/auth/presentation/view/CheckOut/check_out_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/Login/login_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/UserProfile/feedback_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/UserProfile/rate_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  XFile? _profileImage;
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username') ?? 'Guest User';
      _userEmail = prefs.getString('email') ?? 'user@example.com';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('email');
    await prefs.remove('userName');
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginScreen(onLoginSuccess: () {}, initialEmail: null),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: MarketiColors.gray200,
                      backgroundImage: _profileImage != null
                          ? FileImage(File(_profileImage!.path))
                          : const AssetImage(AppAssets.profileOutlined)
                                as ImageProvider,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: MarketiColors.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: MarketiColors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: MarketiColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    _userName,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userEmail,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: MarketiColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            _buildListTile(
              'Account Preferences',
              Icons.person_3_sharp,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutPrompt()),
              ),
            ),

            _buildListTile(
              'Subscription & payment',
              Icons.payment,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackScreen()),
              ),
            ),

            // Updated switch tiles with icons
            _buildSwitchTileWithIcon(
              'App Notifications',
              Icons.notifications_none,
              _notificationsEnabled,
              (value) => setState(() => _notificationsEnabled = value),
            ),

            _buildSwitchTileWithIcon(
              'Dark Mode',
              Icons.dark_mode_outlined,
              _darkMode,
              (value) => setState(() => _darkMode = value),
            ),

            _buildListTile(
              'Rate Us',
              Icons.star_border,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RateScreen()),
              ),
            ),

            _buildListTile(
              'Provide Feedback',
              Icons.feedback_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackScreen()),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MarketiColors.primaryBlue,
                  foregroundColor: MarketiColors.white,
                  minimumSize: const Size(200, 50),
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Original switch tile without icon
  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: MarketiColors.primaryBlue,
      contentPadding: EdgeInsets.zero,
    );
  }

  // New switch tile with icon
  Widget _buildSwitchTileWithIcon(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: MarketiColors.primaryBlue,
      ),
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 24,
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 24,
    );
  }
}
