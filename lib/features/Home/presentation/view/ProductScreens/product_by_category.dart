import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';
import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:marketiapp/features/cart/presentation/view/cart/cart_provider.dart';
import 'package:marketiapp/features/favorites/presentation/view/favourite/favourites_provider.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryName;

  const ProductsByCategoryScreen({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  final int _limit = 10;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialProducts() {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.getProductsByCategory(widget.categoryName, skip: 0, limit: _limit);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    if (_isLoadingMore) return;
    
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    if (homeCubit.state is! HomeProductsLoading) {
      setState(() {
        _isLoadingMore = true;
      });
      _currentPage++;
      homeCubit.getProductsByCategory(
        widget.categoryName, 
        skip: _currentPage * _limit, 
        limit: _limit
      );
    }
  }

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
                  Expanded(
                    child: Text(
                      widget.categoryName,
                      style: const TextStyle(
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

              // Products grid
              Expanded(
                child: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    if (state is HomeProductsSuccess) {
                      setState(() {
                        _isLoadingMore = false;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is HomeProductsLoading && _currentPage == 0) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeProductsFailure) {
                      return Center(
                        child: Text(
                          state.failure.errorModel.message ?? 'Failed to load products',
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (state is HomeProductsSuccess) {
                      final products = state.products.list;
                      
                      if (products.isEmpty) {
                        return Center(
                          child: Text(
                            'No products found in ${widget.categoryName}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return GridView.builder(
                        controller: _scrollController,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: products.length + (_isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= products.length) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          final product = products[index];
                          return _buildProductCard(context, product);
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, dynamic product) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final isFavorite = favoritesProvider.isFavorite(product.id);

    // Extract product data safely
    String title = 'Unknown Product';
    double price = 0.0;
    String thumbnail = '';
    double rating = 0.0;
    String description = '';
    String id = '';

    if (product is Map<String, dynamic>) {
      title = product['title'] ?? product['name'] ?? 'Unknown Product';
      price = (product['price'] ?? 0.0).toDouble();
      thumbnail = product['thumbnail'] ?? product['imageUrl'] ?? '';
      rating = (product['rating'] ?? 0.0).toDouble();
      description = product['description'] ?? '';
      id = product['id']?.toString() ?? '';
    } else {
      title = product.toString();
      id = 'product_${product.hashCode}';
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to product details
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
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: thumbnail.isNotEmpty
                          ? Image.network(
                              thumbnail,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  _buildPlaceholderImage(),
                            )
                          : _buildPlaceholderImage(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product name
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Product category
                  Text(
                    widget.categoryName,
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
                        '\$${price.toStringAsFixed(2)}',
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
                              id,
                              title,
                              thumbnail,
                              price,
                              rating,
                              description,
                              'M', // Default size
                              1,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$title added to cart'),
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
                    favoritesProvider.removeFromFavorites(id);
                  } else {
                    favoritesProvider.addToFavorites({
                      'id': id,
                      'name': title,
                      'imageUrl': thumbnail,
                      'price': price,
                      'rating': rating,
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

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.image, size: 40, color: Colors.grey),
    );
  }
}