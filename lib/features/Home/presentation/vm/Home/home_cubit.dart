import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/core/errors/error_model.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/models/Brand/brands_response.dart';
import 'package:marketiapp/features/Home/data/models/Categories/categories_response.dart';
import 'package:marketiapp/features/Home/data/models/Categories/category_names_response.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/features/home/data/repo/home_repo.dart';


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

      // Check for any failures first
      if (categoriesResult.isLeft()) {
        emit(HomeFailure((categoriesResult as Left).value));
        return;
      }
      
      if (brandsResult.isLeft()) {
        emit(HomeFailure((brandsResult as Left).value));
        return;
      }
      
      if (categoryNamesResult.isLeft()) {
        emit(HomeFailure((categoryNamesResult as Left).value));
        return;
      }
      
      if (productsResult.isLeft()) {
        emit(HomeFailure((productsResult as Left).value));
        return;
      }

      // All results are successful, extract the values
      final categories = (categoriesResult as Right).value;
      final brands = (brandsResult as Right).value;
      final categoryNames = (categoryNamesResult as Right).value;
      final products = (productsResult as Right).value;

      emit(HomeSuccess(
        categories: categories,
        brands: brands,
        categoryNames: categoryNames,
        products: products,
      ));
    } catch (e) {
      emit(HomeFailure(UnknownFailure(ErrorModel(e.toString()))));
    }
  }

  // Alternative cleaner implementation using async/await with error checking
  Future<void> getHomeDataAlternative() async {
    emit(HomeLoading());

    try {
      // Execute all requests in parallel
      final results = await Future.wait([
        homeRepo.getCategories(),
        homeRepo.getBrands(),
        homeRepo.getCategoryNames(),
        homeRepo.getProducts(skip: 0, limit: 10),
      ]);

      // Check for any failures
      for (final result in results) {
        if (result.isLeft()) {
          emit(HomeFailure((result as Left).value));
          return;
        }
      }

      // All results are successful
      emit(HomeSuccess(
        categories: (results[0] as Right).value,
        brands: (results[1] as Right).value,
        categoryNames: (results[2] as Right).value,
        products: (results[3] as Right).value,
      ));
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
    final result = await homeRepo.getCategories();
    result.fold(
      (failure) => emit(HomeCategoriesFailure(failure)),
      (categories) => emit(HomeCategoriesSuccess(categories)),
    );
  }

  // Load only brands
  Future<void> getBrands() async {
    emit(HomeBrandsLoading());
    final result = await homeRepo.getBrands();
    result.fold(
      (failure) => emit(HomeBrandsFailure(failure)),
      (brands) => emit(HomeBrandsSuccess(brands)),
    );
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

  // Load single product by ID
  // Future<void> getProductById(String productId) async {
  //   emit(HomeProductLoading());
  //   try {
  //     final result = await homeRepo.getProductById(productId);
  //     result.fold(
  //       (failure) => emit(HomeProductFailure(failure)),
  //       (product) => emit(HomeProductSuccess(product)),
  //     );
  //   } catch (e) {
  //     emit(HomeProductFailure(UnknownFailure(ErrorModel(e.toString()))));
  //   }
  // }
}