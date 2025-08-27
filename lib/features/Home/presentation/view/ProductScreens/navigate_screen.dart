// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_screen.dart';
// import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_screen.dart';
// import 'package:marketiapp/features/Home/presentation/view/ProductScreens/home_screen.dart';
// import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_provider.dart';

// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _selectedIndex = 0;

//   // Screens for each navigation item
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const CartScreen(),
//     const FavoritesScreen(),
//     const Placeholder(), // Placeholder for menu, will show popup instead
//   ];

//   void _onItemTapped(int index) {
//     if (index == 3) {
//       // Show popup menu instead of navigating to a screen
//       _showMenuPopup(context);
//     } else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   void _showMenuPopup(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.person),
//                 title: const Text('Profile'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ProfileScreen()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.settings),
//                 title: const Text('Settings'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Navigate to settings screen
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history),
//                 title: const Text('Order History'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Navigate to order history screen
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.help),
//                 title: const Text('Help & Support'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Navigate to help screen
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.logout),
//                 title: const Text('Logout'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Implement logout functionality
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
    
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: [
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: _buildCartBadge(cart),
//             label: 'Cart',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.menu),
//             label: 'Menu',
//           ),
//         ],
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   // Custom cart badge widget
//   Widget _buildCartBadge(CartProvider cart) {
//     final itemCount = cart.items.fold(0, (sum, item) => sum + item.quantity);
    
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         const Icon(Icons.shopping_cart),
//         if (itemCount > 0)
//           Positioned(
//             top: -8,
//             right: -8,
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               constraints: const BoxConstraints(
//                 minWidth: 16,
//                 minHeight: 16,
//               ),
//               child: Text(
//                 itemCount.toString(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }