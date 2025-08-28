import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final HomeRepo homeRepo;

  ProductCubit({required this.homeRepo}) : super(ProductInitial());

  Future<void> getProducts({int skip = 0, int limit = 10}) async {
    emit(ProductLoading());
    final result = await homeRepo.getProducts(skip: skip, limit: limit);
    result.fold(
      (failure) => emit(ProductFailure(failure)),
      (products) => emit(ProductSuccess(products)),
    );
  }

  Future<void> getProductById(String productId) async {
    emit(ProductLoading());
    final result = await homeRepo.getProductById(productId);
    result.fold(
      (failure) => emit(ProductFailure(failure)),
      (product) => emit(ProductByIdSuccess(product)),
    );
  }
}