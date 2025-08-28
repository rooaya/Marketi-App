import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Cart/data/models/cart_model.dart';
import 'package:marketiapp/features/Cart/data/models/cart_response.dart';
import 'package:marketiapp/features/Cart/presentation/vm/Cart/cart_cubit.dart';

import 'package:marketiapp/features/Profile/presentation/view/UserProfile/Profile_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Load cart when screen initializes
    // The token is automatically handled by ApiInterceptor
    context.read<CartCubit>().getCart("");
  }

  void _refreshCart() {
    context.read<CartCubit>().getCart("");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartAddSuccess || state is CartRemoveSuccess || state is CartUpdateSuccess) {
          // Refresh cart after any successful operation
          _refreshCart();
        }
      },
      builder: (context, state) {
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
                          'Products on Cart',
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
                  const SizedBox(height: 20),

                  // Cart items list
                  Expanded(
                    child: _buildCartContent(state),
                  ),

                  // Subtotal and Checkout section
                  if (state is CartSuccess && state.cartResponse.items.isNotEmpty)
                    _buildCheckoutSection(context, state.cartResponse),
                  const SizedBox(height: 16),

                  // Bottom navigation
                  _buildBottomNavigationBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCartContent(CartState state) {
    if (state is CartLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CartFailure) {
      return Center(
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
              onPressed: _refreshCart,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is CartSuccess) {
      final cartResponse = state.cartResponse;
      
      if (cartResponse.items.isEmpty) {
        return _buildEmptyCart();
      }

      return ListView.builder(
        itemCount: cartResponse.items.length,
        itemBuilder: (context, index) {
          final item = cartResponse.items[index];
          return _buildCartItemCard(item);
        },
      );
    }

    // Initial state
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add some products to your cart',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product name
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Price
            Text(
              'Price: ${item.price.toStringAsFixed(2)} EGP',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),

            // Quantity controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Item total
                Text(
                  'Total: ${(item.price * item.quantity).toStringAsFixed(2)} EGP',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Quantity controls
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 20),
                      onPressed: () {
                        if (item.quantity > 1) {
                          // Decrease quantity
                          context.read<CartCubit>().updateCartQuantity(
                                "",
                                item.id,
                                item.quantity - 1,
                              );
                        } else {
                          // Remove item if quantity becomes 0
                          context.read<CartCubit>().removeFromCart(
                                "",
                                item.id,
                              );
                        }
                      },
                    ),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: () {
                        // Increase quantity
                        context.read<CartCubit>().updateCartQuantity(
                              "",
                              item.id,
                              item.quantity + 1,
                            );
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Remove button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<CartCubit>().removeFromCart(
                        "",
                        item.id,
                      );
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartResponse cartResponse) {
    final total = cartResponse.items.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final totalItems = cartResponse.items.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          // Subtotal
          const Text(
            'Subtotal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '($totalItems items)',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Total price
          Text(
            '${total.toStringAsFixed(2)} EGP',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),

          // Checkout button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Checkout logic
                _showCheckoutDialog(context, total);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, double total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: Text('Proceed with checkout for ${total.toStringAsFixed(2)} EGP?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement checkout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Checkout functionality coming soon!')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home'),
          _buildNavItem(Icons.shopping_cart, 'Cart', isActive: true),
          _buildNavItem(Icons.favorite, 'Favorites'),
          _buildNavItem(Icons.menu, 'Menu'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.blue : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}