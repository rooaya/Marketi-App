// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketiapp/core/resources/assets_manager.dart';
// import 'package:marketiapp/features/vm/user_cubit.dart';
// import 'package:marketiapp/features/vm/user_state.dart';
// import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';

// class BrandsScreen extends StatelessWidget {
//   const BrandsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userCubit = BlocProvider.of<UserCubit>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header with back button and profile icon
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'Brands',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.center,
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
//               const SizedBox(height: 16),

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
//                             Image.asset(AppAssets.placeholder),
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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // All Brands title
//           const Text(
//             'All Brands',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Brands grid
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2,
//               childAspectRatio: 1.0,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 16,
//               children: [
//                 _buildBrandCard('TOWN TEAM', AppAssets.TownTeam),
//                 _buildBrandCard('JBL', AppAssets.JBL),
//                 _buildBrandCard('Pampers', AppAssets.Pampers),
//                 _buildBrandCard('Canon', AppAssets.Canon),
//                 _buildBrandCard('adidas', AppAssets.adidas),
//                 _buildBrandCard('Apple', AppAssets.apple),
//                 _buildBrandCard('LACOSTE', AppAssets.lacost),
//                 _buildBrandCard('TOSHIBA', AppAssets.toshipa),
//               ],
//             ),
//           ),
//         ],
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
//             errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
//           ),
//           title: Text(item['name'] ?? ''),
//           subtitle: Text(item['description'] ?? ''),
//           onTap: () {
//             // Navigate to brand details
//           },
//         );
//       },
//     );
//   }

//   Widget _buildBrandCard(String brandName, String imagePath) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imagePath,
//             width: 80,
//             height: 80,
//             fit: BoxFit.contain,
//             errorBuilder: (context, error, stackTrace) => Container(
//               width: 80,
//               height: 80,
//               color: Colors.grey[200],
//               child: const Icon(Icons.branding_watermark),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             brandName,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }