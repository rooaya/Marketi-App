import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Categories/category_model.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/category_card.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_category.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';


class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
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
    );
  }

  Widget _buildCategoriesGrid(BuildContext context, List<Category> categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(
          category: category,
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
        );
      },
    );
  }
}