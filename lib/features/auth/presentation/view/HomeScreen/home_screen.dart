import 'package:flutter/material.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/auth/presentation/view/Cart/badge_icon.dart';
import 'package:marketiapp/features/auth/presentation/view/Cart/cart_provider.dart';
import 'package:marketiapp/features/auth/presentation/view/Cart/cart_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/Favourite/favourites_provider.dart';
import 'package:marketiapp/features/auth/presentation/view/Favourite/favourites_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';

class ProductHomePage extends StatelessWidget {
  const ProductHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow and header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Popular Product',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
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

              // Search bar with hint text and blue border
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
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppAssets.offers,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // All Products section aligned left
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Product List in grid view
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // First discount group
                      _buildDiscountSection("10% OFF", [
                        _buildProductRow([
                          _buildProductItem(
                            context,
                            "78",
                            "Sony Smart TV 55 inch",
                            7999.0,
                            AppAssets.TV,
                            4.9,
                          ),
                          _buildProductItem(
                            context,
                            "67",
                            "Black JBL Airbods",
                            13999.0,
                            AppAssets.airbods,
                            4.9,
                          ),
                        ]),
                        _buildProductRow([
                          _buildProductItem(
                            context,
                            "56",
                            "Smart watch",
                            14999.0,
                            AppAssets.watch,
                            4.8,
                          ),
                          const SizedBox(), // Empty space to maintain grid
                        ]),
                      ]),

                      // Second discount group
                      _buildDiscountSection("499 LE", [
                        _buildProductRow([
                          _buildProductItem(
                            context,
                            "23",
                            "Canon 5D camera",
                            499.0,
                            AppAssets.camera,
                            4.9,
                          ),
                          _buildProductItem(
                            context,
                            "8",
                            "Womens Ankle Boots",
                            499.0,
                            AppAssets.ankle,
                            4.5,
                          ),
                        ]),
                      ]),

                      // Third discount group
                      _buildDiscountSection("50% off", [
                        _buildProductRow([
                          _buildProductItem(
                            context,
                            "6",
                            "Black Sony Headphone",
                            399.0,
                            AppAssets.headphone,
                            4.5,
                          ),
                          _buildProductItem(
                            context,
                            "4",
                            "HP Chromebook laptop",
                            14999.0,
                            AppAssets.laptop,
                            4.7,
                          ),
                        ]),
                      ]),
                      _buildDiscountSection("5% off", [
                        _buildProductRow([
                          _buildProductItem(
                            context,
                            "12",
                            "lose Powder Huda Beauty",
                            1000.0,
                            AppAssets.losee,
                            4.5,
                          ),
                          _buildProductItem(
                            context,
                            "9",
                            "serial corn Flex",
                            149.0,
                            AppAssets.cornflex,
                            4.7,
                          ),
                        ]),
                      ]),
                    ],
                  ),
                ),
              ),

              // Footer with time
              const Divider(),
              const Center(
                child: Text(
                  '9:41',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountSection(String discountText, List<Widget> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            discountText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        ...products,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProductRow(List<Widget> children) {
    return Row(
      children: children.map((child) => Expanded(child: child)).toList(),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    String id,
    String name,
    double price,
    String imageUrl,
    double rating,
  ) {
    final favoritesProvider = Provider.of<FavoritesProvider>(
      context,
      listen: false,
    );

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$price LE',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(rating.toString()),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          // Favorite icon
          Positioned(
            top: 8,
            right: 8,
            child: Consumer<FavoritesProvider>(
              builder: (context, favorites, child) {
                return IconButton(
                  icon: Icon(
                    favorites.isFavorite(id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favorites.isFavorite(id) ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (favorites.isFavorite(id)) {
                      favorites.removeFromFavorites(id);
                    } else {
                      favorites.addToFavorites({
                        'id': id,
                        'name': name,
                        'price': price,
                        'imageUrl': imageUrl,
                        'rating': rating,
                      });
                    }
                  },
                );
              },
            ),
          ),
          // Add to cart button
          Positioned(
            bottom: 8,
            right: 8,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).addItem(id, name, imageUrl, price);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$name added to cart'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                minimumSize: Size.zero,
              ),
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return BottomNavigationBar(
      currentIndex: 0, // Home is selected
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: BadgeIcon(icon: Icons.shopping_cart, count: cart.items.length),
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
}
