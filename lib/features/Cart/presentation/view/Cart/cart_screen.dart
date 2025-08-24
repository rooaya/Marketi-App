// lib/features/Home/presentation/view/ProductScreens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_provider.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_screen.dart';
import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';

import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    // Load home data when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeCubit.getHomeData();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(context, cart),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar with user greeting
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Welcome to Marketi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_2_rounded, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: "What are you looking for?",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 253, 253),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                ),
                onChanged: (value) {
                  // Implement search functionality if needed
                },
              ),
              const SizedBox(height: 20),

              // Home content with BlocBuilder
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is HomeFailure) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Error: ${state.failure.toString()}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    return _buildNormalContent(context, state);
                  } else {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNormalContent(BuildContext context, HomeSuccess state) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Special Deal Banner
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: Image.asset(
                  AppAssets.offers,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Popular Product Section
            _buildSectionHeader(
              context,
              'Popular Product',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(), //Mariam  const PopularProductScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildHorizontalProductList([
              _buildProductCard(
                context,
                'Black airbods',
                'BBS',
                AppAssets.airbods,
              ),
              _buildProductCard(
                context,
                'Smart Watch',
                'S2 w3',
                AppAssets.watch,
              ),
              _buildProductCard(context, 'Sony TV', '55 inch', AppAssets.TV),
            ]),
            const SizedBox(height: 24),

            // Category Section with dynamic data
            _buildSectionHeader(
              context,
              'Category',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryProductScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              children: state.categories.list.take(6).map((category) {
                return _buildCategoryCard(
                  category.name,
                  category.image ?? AppAssets.camera, // Fallback image
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Brands Section with dynamic data
            _buildSectionHeader(
              context,
              'Brands',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrandsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _buildHorizontalBrandList(
              state.brands.list.take(3).map((brand) {
                return _buildBrandCard(brand.name, brand.emoji ?? '🏢');
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onViewAll,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onViewAll,
          child: const Text('View all', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildHorizontalProductList(List<Widget> items) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) => SizedBox(width: 150, child: items[index]),
      ),
    );
  }

  Widget _buildHorizontalBrandList(List<Widget> items) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String title,
    String subtitle,
    String imagePath,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 40,
              height: 40,
              color: Colors.grey[200],
              child: const Icon(Icons.category, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(String brandName, String emoji) {
    return SizedBox(
      width: 120,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                brandName,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, CartProvider cart) {
    return BottomNavigationBar(
      currentIndex: 0, // Home is selected
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: _buildCartBadge(cart),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
      onTap: (index) {
        switch (index) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            );
            break;
          // Case 0 (Home) and 3 (Menu) don't need actions
        }
      },
    );
  }

  // Custom cart badge widget
  Widget _buildCartBadge(CartProvider cart) {
    final itemCount = cart.items.fold(0, (sum, item) => sum + item.quantity);
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_cart),
        if (itemCount > 0)
          Positioned(
            top: -8,
            right: -8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                itemCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}