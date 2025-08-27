import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_card.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';


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
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
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

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: products.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= products.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final product = products[index];
                  return ProductCard(product: product, onTap: () {  },);
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}