import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Categories/category_model.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_category.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:marketiapp/features/favorites/presentation/view/favourite/favourites_provider.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key});

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
                      'Categories',
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

              // All Categories title
              const Text(
                'All Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Categories grid
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeFailure) {
                      return Center(
                        child: Text(
                          'Error: ${state.failure.errorModel.message}',
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (state is HomeSuccess) {
                      return _buildCategoriesGrid(
                        context,
                        state.categories.list.cast<Category>(),
                      );
                    } else {
                      return const Center(child: Text('No categories available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context, List<Category> categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(context, category);
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category category) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final isFavorite = favoritesProvider.isFavorite(category.name);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsByCategoryScreen(
                categoryName: category.name,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Category icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      _getCategoryIcon(category.name),
                      size: 30,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Category name
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  
                  // View products button
                  Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'View Products',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Favorite icon in top right corner
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  if (isFavorite) {
                    favoritesProvider.removeFromFavorites(category.name);
                  } else {
                    favoritesProvider.addToFavorites({
                      'id': category.name,
                      'name': category.name,
                      'imageUrl': '',
                      'price': 0.0,
                      'rating': 0.0,
                      'type': 'category',
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'electronics':
        return Icons.electrical_services;
      case 'furniture':
        return Icons.chair;
      case 'food':
        return Icons.fastfood;
      case 'plants':
        return Icons.local_florist;
      case 'phones':
        return Icons.phone_iphone;
      case 'fashion':
        return Icons.shopping_bag;
      case 'gaming':
        return Icons.sports_esports;
      default:
        return Icons.category;
    }
  }
}