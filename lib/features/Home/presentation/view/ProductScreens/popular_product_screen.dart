// lib/features/Home/presentation/view/ProductScreens/popular_product_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Cart/presentation/vm/Cart/cart_cubit.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:marketiapp/features/Favorites/presentation/vm/Favorite/favorite_cubit.dart';

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

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
                      'Popular Products',
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
                onChanged: (value) {
                  // Implement search functionality if needed
                },
              ),
              const SizedBox(height: 20),

              // Content with BlocBuilder
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
                        ),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    return _buildNormalContent(context, state.products.list);
                  } else {
                    return const Expanded(
                      child: Center(child: Text('No products available')),
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

  Widget _buildNormalContent(BuildContext context, List<dynamic> products) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // All Products title
            const Text(
              'Popular Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Product list with scroll
            if (products.isEmpty)
              const Center(
                child: Text(
                  'No popular products available',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            else
              Column(
                children: [
                  _buildProductGroup("Featured Products", products),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGroup(String groupTitle, List<dynamic> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            groupTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductItem(context, product);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProductItem(BuildContext context, dynamic product) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: BlocProvider.of<CartCubit>(context)),
        BlocProvider.value(value: BlocProvider.of<FavoriteCubit>(context)),
      ],
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, favoriteState) {
          // Extract product data safely
          String title = 'Unknown Product';
          double price = 0.0;
          String thumbnail = '';
          double rating = 0.0;
          String id = '';

          if (product is Map<String, dynamic>) {
            title = product['title'] ?? product['name'] ?? 'Unknown Product';
            price = (product['price'] ?? 0.0).toDouble();
            thumbnail = product['thumbnail'] ?? product['imageUrl'] ?? '';
            rating = (product['rating'] ?? 0.0).toDouble();
            id = product['id']?.toString() ?? '';
          } else {
            title = product.toString();
            id = 'product_${product.hashCode}';
          }

          final isFavorite = favoriteState is FavoriteSuccess && 
              favoriteState.favoriteResponse.list.any((item) => item.id == id);

          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Navigate to product details
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: thumbnail.isNotEmpty
                            ? Image.network(
                                thumbnail,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.image, size: 40),
                                ),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, size: 40),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Product name
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Product price
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Rating and Add to Cart
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              context.read<FavoriteCubit>().removeFromFavorite("", id);
                            } else {
                              context.read<FavoriteCubit>().addToFavorite("", id);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart, size: 20),
                          onPressed: () {
                            context.read<CartCubit>().addToCart("", id, 1);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$title added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}