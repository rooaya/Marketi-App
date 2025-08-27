// lib/features/Home/presentation/view/ProductScreens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_provider.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_screen.dart';
import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_screen.dart';
import 'package:marketiapp/features/Home/data/models/Brand/brand_model.dart';
import 'package:marketiapp/features/Home/data/models/Categories/category_model.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_brand.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_category.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_details_screen.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:marketiapp/features/favorites/presentation/view/favourite/favourites_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load home data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(context, cart),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                return _buildHomeContent(context, state);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, HomeSuccess state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with greeting and profile
          _buildHeader(),
          const SizedBox(height: 20),
          
          // Search bar
          _buildSearchBar(),
          const SizedBox(height: 24),
          
          // Special Deal Banner
          _buildSpecialDealBanner(),
          const SizedBox(height: 24),
          
          // Popular products section - Show only 3 products
          _buildPopularProductsSection(
            context, 
            state.products.list.cast<Product>().take(3).toList()
          ),
          const SizedBox(height: 24),
          
          // Categories section - Show only 6 categories
          _buildCategoriesSection(
            context, 
            state.categories.list.cast<Category>().take(6).toList()
          ),
          const SizedBox(height: 24),
          
          // Brands section - Show only 3 brands
          _buildBrandsSection(
            context, 
            state.brands.list.cast<Brand>().take(3).toList()
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HI Yousef!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'What are you looking for?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "What are you looking for?",
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildSpecialDealBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SPECIAL DEAL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'SUPER OFFER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularProductsSection(BuildContext context, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Product',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PopularProductScreen(),
                  ),
                );
              },
              child: const Text(
                'View all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return SizedBox(
                width: 160,
                child: _buildProductCard(context, product),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final isFavorite = favoritesProvider.isFavorite(product.id);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                id: product.id,
                name: product.title,
                imageUrl: product.thumbnail,
                price: product.price,
                rating: product.rating,
                description: product.description,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image with favorite icon
              Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: product.thumbnail.isNotEmpty
                          ? Image.network(
                              product.thumbnail,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  _buildPlaceholderImage(),
                            )
                          : _buildPlaceholderImage(),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          favoritesProvider.removeFromFavorites(product.id);
                        } else {
                          favoritesProvider.addToFavorites({
                            'id': product.id,
                            'name': product.title,
                            'imageUrl': product.thumbnail,
                            'price': product.price,
                            'rating': product.rating,
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Product name
              Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Product brand
              Text(
                product.brand,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Price and Add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 16, color: Colors.white),
                      onPressed: () {
                        final cartProvider = Provider.of<CartProvider>(context, listen: false);
                        cartProvider.addItem(
                          product.id,
                          product.title,
                          product.thumbnail,
                          product.price,
                          product.rating,
                          product.description,
                          'M', // Default size
                          1,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, List<Category> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryProductScreen(),
                  ),
                );
              },
              child: const Text(
                'View all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, Category category) {
    return Card(
      elevation: 2,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(Icons.category, size: 30, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandsSection(BuildContext context, List<Brand> brands) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Brands',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrandsScreen(),
                  ),
                );
              },
              child: const Text(
                'View all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildBrandCard(context, brand),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBrandCard(BuildContext context, Brand brand) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsByBrandScreen(
                brandName: brand.name,
              ),
            ),
          );
        },
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                brand.emoji.isNotEmpty ? brand.emoji : '🏢',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                brand.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
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

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, CartProvider cart) {
    final itemCount = cart.items.fold(0, (sum, item) => sum + item.quantity);
    
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart),
              if (itemCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
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
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
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
        }
      },
    );
  }
}

