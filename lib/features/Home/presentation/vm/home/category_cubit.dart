import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Categories/categories_response.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeRepo homeRepo;

  CategoryCubit({required this.homeRepo}) : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    final result = await homeRepo.getCategories();
    result.fold(
      (failure) => emit(CategoryFailure(failure)),
      (categories) => emit(CategorySuccess(categories)),
    );
  }
}