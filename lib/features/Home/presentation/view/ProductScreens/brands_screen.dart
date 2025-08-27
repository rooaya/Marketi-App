import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Brand/brand_model.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/brand_card.dart';
import 'package:marketiapp/features/Home/presentation/view/ProductScreens/product_by_brand.dart';
import 'package:marketiapp/features/Home/presentation/vm/Home/home_cubit.dart';


class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Brands',
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
              return _buildBrandsGrid(
                context,
                state.brands.list.cast<Brand>(),
              );
            } else {
              return const Center(child: Text('No brands available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildBrandsGrid(BuildContext context, List<Brand> brands) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];
        return BrandCard(
          brand: brand,
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
        );
      },
    );
  }
}