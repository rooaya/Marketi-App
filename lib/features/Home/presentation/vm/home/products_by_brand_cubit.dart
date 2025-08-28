import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';

part 'products_by_brand_state.dart';

class ProductsByBrandCubit extends Cubit<ProductsByBrandState> {
  final HomeRepo homeRepo;
  final String brandName;

  ProductsByBrandCubit({required this.homeRepo, required this.brandName}) : super(ProductsByBrandInitial());

  Future<void> getProducts({int skip = 0, int limit = 10}) async {
    if (skip == 0) emit(ProductsByBrandLoading());

    final result = await homeRepo.getProductsByBrand(brandName, skip: skip, limit: limit);
    result.fold(
      (failure) => emit(ProductsByBrandFailure(failure)),
      (products) {
        if (state is ProductsByBrandSuccess) {
          final currentState = state as ProductsByBrandSuccess;
          final combinedProducts = ProductsResponse(
            list: [...currentState.products.list, ...products.list],
            total: products.total,
            skip: skip,
            limit: limit,
          );
          emit(ProductsByBrandSuccess(combinedProducts));
        } else {
          emit(ProductsByBrandSuccess(products));
        }
      },
    );
  }
}