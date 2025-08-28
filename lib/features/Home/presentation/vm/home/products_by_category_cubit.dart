import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';

part 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final HomeRepo homeRepo;
  final String categoryName;

  ProductsByCategoryCubit({required this.homeRepo, required this.categoryName}) : super(ProductsByCategoryInitial());

  Future<void> getProducts({int skip = 0, int limit = 10}) async {
    if (skip == 0) emit(ProductsByCategoryLoading());

    final result = await homeRepo.getProductsByCategory(categoryName, skip: skip, limit: limit);
    result.fold(
      (failure) => emit(ProductsByCategoryFailure(failure)),
      (products) {
        if (state is ProductsByCategorySuccess) {
          final currentState = state as ProductsByCategorySuccess;
          final combinedProducts = ProductsResponse(
            list: [...currentState.products.list, ...products.list],
            total: products.total,
            skip: skip,
            limit: limit,
          );
          emit(ProductsByCategorySuccess(combinedProducts));
        } else {
          emit(ProductsByCategorySuccess(products));
        }
      },
    );
  }
}