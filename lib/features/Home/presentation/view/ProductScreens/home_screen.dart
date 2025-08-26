// lib/features/home/presentation/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/resources/assets_manager.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/badge_icon.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_provider.dart';
import 'package:marketiapp/features/Cart/presentation/view/Cart/cart_screen.dart';
import 'package:marketiapp/features/Favorites/presentation/view/Favourite/favourites_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brands_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_product_screen.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/popular_product_screen.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    // Load home data when screen is built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   homeCubit.getHomeData();
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar
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
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 253, 253),
                  ),
                ),
                const SizedBox(height: 20),
                //! --------------------------------------------------------
                Column(
                  children: [
                    // Category Section
                    _buildSectionHeader(context, 'Category', 'category_product_screen'),
                    const SizedBox(height: 8),
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (previous, current) => current is HomeCategoriesLoading || current is HomeCategoriesSuccess || current is HomeCategoriesFailure,
                      builder: (context, state) {
                        if (state is HomeCategoriesLoading) {
                          return Center(child: Text("HomeCategoriesLoading.....!"));
                        } else if (state is HomeCategoriesFailure) {
                          return Center(child: Text("HomeCategoriesFailure.....!"));
                        } else if (state is HomeCategoriesSuccess) {
                          return SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.list.length,
                              itemBuilder: (context, index) => _buildCategoryCard(state.categories.list[index].name, state.categories.list[index].image),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   crossAxisCount: 3,
                    //   childAspectRatio: 0.8,
                    //   children: state.categories.list.take(6).map((category) {
                    //     return _buildCategoryCard(category.name, category.image);
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 24),

                    // Brands Section
                    _buildSectionHeader(context, 'Brands', 'brands_screen'),
                    const SizedBox(height: 8),
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (previous, current) => current is HomeBrandsLoading || current is HomeBrandsSuccess || current is HomeBrandsFailure,
                      builder: (context, state) {
                        if (state is HomeBrandsLoading) {
                          return Center(child: Text("HomeCategoriesLoading.....!"));
                        } else if (state is HomeBrandsFailure) {
                          return Center(child: Text("HomeCategoriesFailure.....!"));
                        } else if (state is HomeBrandsSuccess) {
                          return SizedBox(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.brands.list.length,
                                itemBuilder: (context, index) => _buildBrandCard(
                                      state.brands.list[index].name,
                                      state.brands.list[index].emoji,
                                    )
                                // _buildCategoryCard(state.brands.list[index].name, state.categories.list[index].image),
                                ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    // _buildHorizontalProductList(
                    //   state.brands.list.take(3).map((brand) {
                    //     return _buildBrandCard(brand.name, brand.emoji);
                    //   }).toList(),
                    // ),
                    const SizedBox(height: 16),
                    // _buildNormalContent(context, state),
                  ],
                ),
                // Home content
                // BlocBuilder<HomeCubit, HomeState>(
                //   builder: (context, state) {
                //     if (state is HomeCategoryNamesLoading) {
                //       return const Expanded(
                //         child: Center(child: CircularProgressIndicator()),
                //       );
                //     } else if (state is HomeFailure) {
                //       return Expanded(
                //         child: Center(
                //           child: Text(
                //             state.failure.errorModel.message ?? "Error...!",
                //           ),
                //         ),
                //       );
                //     } else if (state is HomeCategoryNamesSuccess) {
                //       return Column(
                //         children: [
                //           // Category Section
                //           _buildSectionHeader(context, 'Category', 'category_product_screen'),
                //           const SizedBox(height: 8),
                //           GridView.count(
                //             shrinkWrap: true,
                //             physics: const NeverScrollableScrollPhysics(),
                //             crossAxisCount: 3,
                //             childAspectRatio: 0.8,
                //             children: state.categories.list.take(6).map((category) {
                //               return _buildCategoryCard(category.name, category.image);
                //             }).toList(),
                //           ),
                //           const SizedBox(height: 24),

                //           // Brands Section
                //           _buildSectionHeader(context, 'Brands', 'brands_screen'),
                //           const SizedBox(height: 8),
                //           _buildHorizontalProductList(
                //             state.brands.list.take(3).map((brand) {
                //               return _buildBrandCard(brand.name, brand.emoji);
                //             }).toList(),
                //           ),
                //           const SizedBox(height: 16),
                //           // _buildNormalContent(context, state),
                //         ],
                //       );
                //       // return ListView.builder(
                //       //   itemBuilder: (context, index) {
                //       //     return Text(state.categoryNames.list[index].name);
                //       //   },
                //       //   itemCount: state.categoryNames.list.length,
                //       // );
                //     } else if (state is HomeCategoriesFailure) {
                //       return Text("error");
                //     } else {
                //       return const Expanded(
                //         child: Center(child: CircularProgressIndicator()),
                //       );
                //     }
                //   },
                // ),
              ],
            ),
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
              'popular_product_screen',
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

            // Category Section
            _buildSectionHeader(context, 'Category', 'category_product_screen'),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              children: state.categories.list.take(6).map((category) {
                return _buildCategoryCard(category.name, category.image);
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Brands Section
            _buildSectionHeader(context, 'Brands', 'brands_screen'),
            const SizedBox(height: 8),
            _buildHorizontalProductList(
              state.brands.list.take(3).map((brand) {
                return _buildBrandCard(brand.name, brand.emoji);
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
    String routeName,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            switch (routeName) {
              case 'popular_product_screen':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PopularProductScreen(),
                  ),
                );
                break;
              case 'category_product_screen':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryProductScreen(),
                  ),
                );
                break;
              case 'brands_screen':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BrandsScreen()),
                );
                break;
            }
          },
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

  Widget _buildCategoryCard(String title, String? imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null && imagePath.isNotEmpty)
            Image.network(
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
            )
          else
            Container(
              width: 40,
              height: 40,
              color: Colors.grey[200],
              child: const Icon(Icons.category, size: 24),
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
      // width: 120,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              // const SizedBox(height: 8),
              Text(
                brandName,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return BottomNavigationBar(
      currentIndex: 0,
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
        }
      },
    );
  }
}
