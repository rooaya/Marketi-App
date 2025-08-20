// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketiapp/core/resources/assets_manager.dart';
// import 'package:marketiapp/features/vm/user_cubit.dart';
// import 'package:marketiapp/features/vm/user_state.dart';
// import 'package:marketiapp/features/Cart/presentation/view/Cart/badge_icon.dart';
// import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_provider.dart';
// import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_screen.dart';
// import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_screen.dart';
// import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
// import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
// import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
// import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_details_screen.dart';
// import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//     final userCubit = BlocProvider.of<UserCubit>(context);
//     final userEmail = userCubit.signInEmail.text;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: _buildBottomNavigationBar(context),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // AppBar with user email
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Welcome, ${userEmail.split('@')[0]}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.person_2_rounded, size: 30),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ProfileScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),

//               // Search bar
//               BlocBuilder<UserCubit, UserState>(
//                 builder: (context, state) {
//                   return TextField(
//                     controller: userCubit.searchController,
//                     decoration: InputDecoration(
//                       hintText: "What are you looking for?",
//                       prefixIcon: const Icon(Icons.search),
//                       suffixIcon: userCubit.searchController.text.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () {
//                                 userCubit.searchController.clear();
//                                 userCubit.search('');
//                               },
//                             )
//                           : null,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                           width: 1.0,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                           width: 1.0,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(
//                           color: Colors.blue,
//                           width: 2.0,
//                         ),
//                       ),
//                       filled: true,
//                       fillColor: const Color.fromARGB(255, 255, 253, 253),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 20,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       userCubit.search(value);
//                     },
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Show search results or normal content
//               BlocBuilder<UserCubit, UserState>(
//                 builder: (context, state) {
//                   if (state is SearchLoading) {
//                     return const Expanded(
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   } else if (state is SearchSuccess) {
//                     return Expanded(
//                       child: _buildSearchResults(state.results, context),
//                     );
//                   } else if (state is SearchEmpty) {
//                     return Expanded(
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(state.emptyImagePath),
//                             const Text('No results found'),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else if (state is SearchFailure) {
//                     return Expanded(
//                       child: Center(child: Text(state.errMessage)),
//                     );
//                   } else {
//                     return _buildNormalContent(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNormalContent(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Special Deal Banner
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 120,
//                 child: Image.asset(
//                   AppAssets.offers,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     color: Colors.grey[200],
//                     child: const Center(child: Icon(Icons.image)),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Popular Product Section
//             _buildSectionHeader(
//               context,
//               'Popular Product',
//               'popular_product_screen',
//             ),
//             const SizedBox(height: 8),
//             _buildHorizontalProductList([
//               _buildProductCard(
//                 context,
//                 'Black airbods',
//                 'BBS',
//                 AppAssets.airbods,
//               ),
//               _buildProductCard(
//                 context,
//                 'Smart Watch',
//                 'S2 w3',
//                 AppAssets.watch,
//               ),
//               _buildProductCard(context, 'Sony TV', '55 inch', AppAssets.TV),
//             ]),
//             const SizedBox(height: 24),

//             // Category Section
//             _buildSectionHeader(context, 'Category', 'category_product_screen'),
//             const SizedBox(height: 8),
//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 3,
//               childAspectRatio: 0.8,
//               children: [
//                 _buildCategoryCard('Pampers', AppAssets.Pampers),
//                 _buildCategoryCard('Electronics', AppAssets.camera),
//                 _buildCategoryCard('Plants', AppAssets.plants),
//                 _buildCategoryCard('Phones', AppAssets.phones),
//                 _buildCategoryCard('Food', AppAssets.cornflex),
//                 _buildCategoryCard('Fashion', AppAssets.fashion),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Brands Section
//             _buildSectionHeader(context, 'Brands', 'brands_screen'),
//             const SizedBox(height: 8),
//             _buildHorizontalProductList([
//               _buildBrandCard('TownTeam', AppAssets.TownTeam),
//               _buildBrandCard('Lacost', AppAssets.lacost),
//               _buildBrandCard('Adidas', AppAssets.adidas),
//             ]),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchResults(List<dynamic> results, BuildContext context) {
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final item = results[index];
//         return ListTile(
//           leading: Image.network(
//             item['image'] ?? '',
//             width: 50,
//             height: 50,
//             errorBuilder: (context, error, stackTrace) =>
//                 const Icon(Icons.image),
//           ),
//           title: Text(item['name'] ?? ''),
//           subtitle: Text('\$${item['price']?.toString() ?? ''}'),
//           onTap: () {
//             // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(id: id, name: name, imageUrl: imageUrl, price: price, rating: rating, description: description)))
//           },
//         );
//       },
//     );
//   }

//   Widget _buildSectionHeader(
//     BuildContext context,
//     String title,
//     String routeName,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         TextButton(
//           onPressed: () {
//             // Navigation logic based on routeName
//             switch (routeName) {
//               case 'popular_product_screen':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const PopularProductScreen(),
//                   ),
//                 );
//                 break;
//               case 'category_product_screen':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const CategoryProductScreen(),
//                   ),
//                 );
//                 break;
//               case 'brands_screen':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const BrandsScreen()),
//                 );
//                 break;
//             }
//           },
//           child: const Text('View all', style: TextStyle(color: Colors.blue)),
//         ),
//       ],
//     );
//   }

//   Widget _buildHorizontalProductList(List<Widget> items) {
//     return SizedBox(
//       height: 180,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: items.length,
//         separatorBuilder: (context, index) => const SizedBox(width: 12),
//         itemBuilder: (context, index) =>
//             SizedBox(width: 150, child: items[index]),
//       ),
//     );
//   }

//   Widget _buildProductCard(
//     BuildContext context,
//     String title,
//     String subtitle,
//     String imagePath,
//   ) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product image with fixed size
//             Center(
//               child: SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     color: Colors.grey[200],
//                     child: const Icon(Icons.image),
//                   ),
//                   height: 100,
//                   width: 100,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//             ),
//             Text(
//               subtitle,
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryCard(String title, String imagePath) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imagePath,
//             width: 100,
//             height: 100,
//             fit: BoxFit.contain,
//             errorBuilder: (context, error, stackTrace) => Container(
//               width: 50,
//               height: 50,
//               color: Colors.grey[200],
//               child: const Icon(Icons.category),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(title, style: const TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }

//   Widget _buildBrandCard(String brandName, String imagePath) {
//     return SizedBox(
//       width: 120,
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 imagePath,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   width: 60,
//                   height: 60,
//                   color: Colors.grey[200],
//                   child: const Icon(Icons.branding_watermark),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 brandName,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context) {
//     final cart = Provider.of<CartProvider>(context);
//     return BottomNavigationBar(
//       currentIndex: 0, // Home is selected
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       items: [
//         const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(
//           icon: BadgeIcon(icon: Icons.shopping_cart, count: cart.items.length),
//           label: 'Cart',
//         ),
//         const BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Favorites',
//         ),
//         const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
//       ],
//       onTap: (index) {
//         switch (index) {
//           case 1:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const CartScreen()),
//             );
//             break;
//           case 2:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const FavoritesScreen()),
//             );
//             break;
//           // Case 0 (Home) and 3 (Menu) don't need actions
//         }
//       },
//     );
//   }
// }
