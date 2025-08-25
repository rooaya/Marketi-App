// lib/features/home/presentation/cubit/home_cubit.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/errors/error_model.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';
import 'package:marketiapp/features/home/data/models/categories/categories_response.dart';
import 'package:marketiapp/features/home/data/models/categories/category_names_response.dart';
import 'package:marketiapp/features/home/data/models/brand/brands_response.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  
  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  // Load all home data (categories, brands, category names, products)
  Future<void> getHomeData() async {
    emit(HomeLoading());
    
    try {
      final categoriesResult = await homeRepo.getCategories();
      final brandsResult = await homeRepo.getBrands();
      final categoryNamesResult = await homeRepo.getCategoryNames();
      final productsResult = await homeRepo.getProducts(skip: 0, limit: 10);

      // Handle all results
      categoriesResult.fold(
        (failure) => emit(HomeFailure(failure)),
        (categories) {
          brandsResult.fold(
            (failure) => emit(HomeFailure(failure)),
            (brands) {
              categoryNamesResult.fold(
                (failure) => emit(HomeFailure(failure)),
                (categoryNames) {
                  productsResult.fold(
                    (failure) => emit(HomeFailure(failure)),
                    (products) {
                      emit(HomeSuccess(
                        categories: categories,
                        brands: brands,
                        categoryNames: categoryNames,
                        products: products,
                      ));
                    },
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      emit(HomeFailure(UnknownFailure(ErrorModel(e.toString()))));
    }
  }

  // Load products with pagination
  Future<void> getProducts({int skip = 0, int limit = 10}) async {
    emit(HomeProductsLoading());
    try {
      final result = await homeRepo.getProducts(skip: skip, limit: limit);
      result.fold(
        (failure) => emit(HomeProductsFailure(failure)),
        (products) => emit(HomeProductsSuccess(products)),
      );
    } catch (e) {
      emit(HomeProductsFailure(UnknownFailure(ErrorModel(e.toString()))));
    }
  }

// lib/features/home/presentation/cubit/home_cubit.dart (Update these methods)
// Load products by category with pagination
Future<void> getProductsByCategory(String categoryName, {int skip = 0, int limit = 10}) async {
  if (skip == 0) {
    emit(HomeProductsLoading());
  }

  try {
    final result = await homeRepo.getProductsByCategory(categoryName, skip: skip, limit: limit);
    result.fold(
      (failure) => emit(HomeProductsFailure(failure)),
      (products) {
        if (state is HomeProductsSuccess) {
          final currentState = state as HomeProductsSuccess;
          final updatedProducts = ProductsResponse(
            list: [...currentState.products.list, ...products.list],
            total: products.total,
            skip: skip,
            limit: limit,
          );
          emit(HomeProductsSuccess(updatedProducts));
        } else {
          emit(HomeProductsSuccess(products));
        }
      },
    );
  } catch (e) {
    emit(HomeProductsFailure(UnknownFailure(ErrorModel(e.toString()))));
  }
}

// Load products by brand with pagination
Future<void> getProductsByBrand(String brandName, {int skip = 0, int limit = 10}) async {
  if (skip == 0) {
    emit(HomeProductsLoading());
  }

  try {
    final result = await homeRepo.getProductsByBrand(brandName, skip: skip, limit: limit);
    result.fold(
      (failure) => emit(HomeProductsFailure(failure)),
      (products) {
        if (state is HomeProductsSuccess) {
          final currentState = state as HomeProductsSuccess;
          final updatedProducts = ProductsResponse(
            list: [...currentState.products.list, ...products.list],
            total: products.total,
            skip: skip,
            limit: limit,
          );
          emit(HomeProductsSuccess(updatedProducts));
        } else {
          emit(HomeProductsSuccess(products));
        }
      },
    );
  } catch (e) {
    emit(HomeProductsFailure(UnknownFailure(ErrorModel(e.toString()))));
  }
}

  
  // Load only categories
  Future<void> getCategories() async {
    emit(HomeCategoriesLoading());
    try {
      final result = await homeRepo.getCategories();
      result.fold(
        (failure) => emit(HomeCategoriesFailure(failure)),
        (categories) => emit(HomeCategoriesSuccess(categories)),
      );
    } catch (e) {
      emit(HomeCategoriesFailure(UnknownFailure(ErrorModel(e.toString()))));
    }
  }

  // Load only brands
  Future<void> getBrands() async {
    emit(HomeBrandsLoading());
    try {
      final result = await homeRepo.getBrands();
      result.fold(
        (failure) => emit(HomeBrandsFailure(failure)),
        (brands) => emit(HomeBrandsSuccess(brands)),
      );
    } catch (e) {
      emit(HomeBrandsFailure(UnknownFailure(ErrorModel(e.toString()))));
    }
  }

  // Load only category names
  Future<void> getCategoryNames() async {
    emit(HomeCategoryNamesLoading());
    try {
      final result = await homeRepo.getCategoryNames();
      result.fold(
        (failure) => emit(HomeCategoryNamesFailure(failure)),
        (categoryNames) => emit(HomeCategoryNamesSuccess(categoryNames)),
      );
    } catch (e) {
      emit(HomeCategoryNamesFailure(UnknownFailure(ErrorModel(e.toString()))));
    }
  }
}