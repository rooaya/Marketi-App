import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/helpers/navigation_helper.dart';
import 'package:marketiapp/features/Cart/presentation/vm/Cart/cart_cubit.dart';
import 'package:marketiapp/features/Favorites/presentation/vm/Favorite/favorite_cubit.dart';
import 'package:marketiapp/features/Home/data/models/Brand/brand_model.dart';
import 'package:marketiapp/features/Home/data/models/Categories/category_model.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_brand.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_category.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_details_screen.dart';

import 'package:marketiapp/features/Home/presentation/vm/home/brand_cubit.dart';
import 'package:marketiapp/features/Home/presentation/vm/home/category_cubit.dart';
import 'package:marketiapp/features/Home/presentation/vm/home/product_cubit.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:marketiapp/features/cart/presentation/view/Cart/cart_screen.dart';
import 'package:marketiapp/features/favorites/presentation/view/favourite/favourites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    
    // Load data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isMounted) {
        // Load favorites and cart data
        context.read<FavoriteCubit>().getFavorites("");
        context.read<CartCubit>().getCart("");
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_isMounted && state is CartAddSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added to cart')),
                );
              }
            });
          },
        ),
        BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_isMounted) return;
              
              if (state is FavoriteAddSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to favorites')),
                );
              } else if (state is FavoriteRemoveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Removed from favorites')),
                );
              }
            });
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: _buildBottomNavigationBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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

                  // Popular products section
                  _buildPopularProductsSection(context),
                  const SizedBox(height: 24),

                  // Categories section
                  _buildCategoriesSection(context),
                  const SizedBox(height: 24),

                  // Brands section
                  _buildBrandsSection(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
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
            NavigationHelper.navigateTo(context, const ProfileScreen());
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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

  Widget _buildPopularProductsSection(BuildContext context) {
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
                NavigationHelper.navigateTo(context, const PopularProductScreen());
              },
              child: const Text(
                'View all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProductCubit, ProductState>(
          buildWhen: (previous, current) =>
              current is ProductLoading ||
              current is ProductSuccess ||
              current is ProductFailure,
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: Text("ProductsLoading.....!"));
            } else if (state is ProductFailure) {
              return const Center(child: Text("ProductsFailure.....!"));
            } else if (state is ProductSuccess) {
              final products = state.products.list.cast<Product>().take(3).toList();
              return SizedBox(
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
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final isFavorite = state is FavoriteSuccess &&
            state.favoriteResponse.list.any((item) => item.id == product.id);

        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(right: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              NavigationHelper.navigateTo(
                context,
                ProductDetailsScreen(
                  id: product.id,
                  name: product.title,
                  imageUrl: product.thumbnail,
                  price: product.price,
                  rating: product.rating,
                  description: product.description,
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
                            if (!_isMounted) return;
                            
                            if (isFavorite) {
                              context
                                  .read<FavoriteCubit>()
                                  .removeFromFavorite("", product.id);
                            } else {
                              context
                                  .read<FavoriteCubit>()
                                  .addToFavorite("", product.id);
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
                          icon: const Icon(Icons.add,
                              size: 16, color: Colors.white),
                          onPressed: () {
                            if (_isMounted) {
                              context
                                  .read<CartCubit>()
                                  .addToCart("", product.id, 1);
                            }
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
      },
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
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
                NavigationHelper.navigateTo(context, const CategoryProductScreen());
              },
              child: const Text(
                'View all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<CategoryCubit, CategoryState>(
          buildWhen: (previous, current) =>
              current is CategoryLoading ||
              current is CategorySuccess ||
              current is CategoryFailure,
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: Text("CategoriesLoading.....!"));
            } else if (state is CategoryFailure) {
              return const Center(child: Text("CategoriesFailure.....!"));
            } else if (state is CategorySuccess) {
              final categories = state.categories.list.cast<Category>().take(6).toList();
              return GridView.builder(
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
              );
            } else {
              return const SizedBox.shrink();
            }
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
          NavigationHelper.navigateTo(
            context,
            ProductsByCategoryScreen(
              categoryName: category.name,
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

  Widget _buildBrandsSection(BuildContext context) {
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
                NavigationHelper.navigateTo(context, const BrandsScreen());
              },
              child: const Text(
                'View all',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<BrandCubit, BrandState>(
          buildWhen: (previous, current) =>
              current is BrandLoading ||
              current is BrandSuccess ||
              current is BrandFailure,
          builder: (context, state) {
            if (state is BrandLoading) {
              return const Center(child: Text("BrandsLoading.....!"));
            } else if (state is BrandFailure) {
              return const Center(child: Text("BrandsFailure.....!"));
            } else if (state is BrandSuccess) {
              final brands = state.brands.list.cast<Brand>().take(3).toList();
              return SizedBox(
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
              );
            } else {
              return const SizedBox.shrink();
            }
          },
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
          NavigationHelper.navigateTo(
            context,
            ProductsByBrandScreen(
              brandName: brand.name,
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int itemCount = 0;

        if (state is CartSuccess) {
          itemCount = state.cartResponse.items
              .fold(0, (sum, item) => sum + item.quantity);
        }

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
                NavigationHelper.navigateTo(context, const CartScreen());
                break;
              case 2:
                NavigationHelper.navigateTo(context, const FavoritesScreen());
                break;
            }
          },
        );
      },
    );
  }
}