// lib/features/Favorites/presentation/view/Favourite/favourites_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Cart/presentation/vm/Cart/cart_cubit.dart';

import 'package:marketiapp/features/Favorites/presentation/vm/Favorite/favorite_cubit.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/home_screen.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:marketiapp/features/cart/presentation/view/Cart/cart_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Load favorites when screen initializes
    // Token is automatically handled by ApiInterceptor
    context.read<FavoriteCubit>().getFavorites("");
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildCartBadge(int count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_cart),
        if (count > 0)
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
                count.toString(),
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteAddSuccess) {
              _showSnackBar('Added to favorites!', isError: false);
            } else if (state is FavoriteRemoveSuccess) {
              _showSnackBar('Removed from favorites!', isError: false);
            } else if (state is FavoriteFailure) {
              _showSnackBar(state.error);
            } else if (state is FavoriteAddFailure) {
              _showSnackBar(state.error);
            } else if (state is FavoriteRemoveFailure) {
              _showSnackBar(state.error);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: _buildBottomNavigationBar(context, currentIndex: 2),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Favorites',
                        style: TextStyle(
                          fontSize: 26,
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
                
                // Main content
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final isLoading = state is FavoriteLoading || 
                                    state is FavoriteAddLoading || 
                                    state is FavoriteRemoveLoading;

                    if (isLoading) {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    } else if (state is FavoriteSuccess) {
                      final favorites = state.favoriteResponse.list;
                      
                      if (favorites.isEmpty) {
                        return _buildEmptyFavorites(context);
                      }
                      
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'All Products',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.builder(
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  final item = favorites[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: ListTile(
                                      leading: Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.image, color: Colors.grey),
                                      ),
                                      title: Text(
                                        item.name,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          context.read<FavoriteCubit>().removeFromFavorite("", item.id);
                                        },
                                      ),
                                      onTap: () {
                                        // Navigate to product details if needed
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is FavoriteFailure) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, size: 64, color: Colors.red),
                              const SizedBox(height: 16),
                              Text(
                                'Error: ${state.error}',
                                style: const TextStyle(fontSize: 16, color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<FavoriteCubit>().getFavorites("");
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyFavorites(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "No Favorites Yet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Start adding products to your favorites",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Browse Products'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context, {
    required int currentIndex,
  }) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int itemCount = 0;
        
        if (state is CartSuccess) {
          itemCount = state.cartResponse.items.fold(
            0, 
            (sum, item) => sum + item.quantity
          );
        }
        
        return BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
            const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
                break;
              case 2:
                // Already on Favorites screen
                break;
            }
          },
        );
      },
    );
  }
}