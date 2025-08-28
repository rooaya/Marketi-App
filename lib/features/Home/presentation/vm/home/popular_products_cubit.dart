import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';

part 'popular_products_state.dart';

class PopularProductsCubit extends Cubit<PopularProductsState> {
  final HomeRepo homeRepo;

  PopularProductsCubit({required this.homeRepo}) : super(PopularProductsInitial());

  Future<void> getPopularProducts({int skip = 0, int limit = 10}) async {
    if (skip == 0) emit(PopularProductsLoading());

    // Assume your API supports sorting by popularity
    final result = await homeRepo.getProducts(
      skip: skip,
      limit: limit,
      sortBy: 'popularity', // or relevant field
      order: 'desc', // descending order for most popular
    );

    result.fold(
      (failure) => emit(PopularProductsFailure(failure)),
      (products) {
        if (state is PopularProductsSuccess) {
          final currentState = state as PopularProductsSuccess;
          final combinedProducts = ProductsResponse(
            list: [...currentState.products.list, ...products.list],
            total: products.total,
            skip: skip,
            limit: limit,
          );
          emit(PopularProductsSuccess(combinedProducts));
        } else {
          emit(PopularProductsSuccess(products));
        }
      },
    );
  }
}