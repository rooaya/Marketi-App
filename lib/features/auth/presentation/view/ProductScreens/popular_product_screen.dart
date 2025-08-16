import 'package:flutter/material.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/auth/presentation/view/Cart/cart_provider.dart';
import 'package:marketiapp/features/auth/presentation/view/Favourite/favourites_provider.dart';
import 'package:marketiapp/features/auth/presentation/view/ProductScreens/product_details_screen.dart';
import 'package:marketiapp/features/auth/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button and profile icon
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
              const SizedBox(height: 16),

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
              ),
              const SizedBox(height: 20),

              // All Products title
              const Text(
                'All Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Product list with scroll
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // First product group
                      _buildProductGroup("10% OFF", [
                        _buildProductItem(
                          context,
                          "67",
                          "Black JBL Airbods",
                          13999.0,
                          AppAssets.airbods,
                          4.9,
                        ),
                        _buildProductItem(
                          context,
                          "78",
                          "Sony Smart TV 55 inch",
                          750.0,
                          AppAssets.TV,
                          4.9,
                        ),
                      ]),

                      // Second product group
                      _buildProductGroup("499 LE", [
                        _buildProductItem(
                          context,
                          "56",
                          "Smart Watch",
                          499.0,
                          AppAssets.watch,
                          4.8,
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

                      // Third product group
                      _buildProductGroup("399 LE", [
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
                          4.9,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGroup(String discountText, List<Widget> products) {
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
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          children: products,
        ),
        const SizedBox(height: 16),
      ],
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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                id: id,
                name: name,
                imageUrl: imageUrl,
                price: price,
                rating: rating,
                description:
                    "Fear no leaks with new and improved $name. "
                    "$name helps prevent up to 100% of leaks, even blowouts. "
                    "With $name, you can rest assured that you have superior "
                    "protection while keeping everything in perfect condition.",
              ),
            ),
          );
        },
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
                      color: favorites.isFavorite(id)
                          ? Colors.red
                          : Colors.grey,
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
      ),
    );
  }
}
