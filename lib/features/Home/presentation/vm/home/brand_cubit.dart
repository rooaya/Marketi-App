import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketiapp/features/Home/data/models/Brand/brands_response.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/repo/home_repo.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final HomeRepo homeRepo;

  BrandCubit({required this.homeRepo}) : super(BrandInitial());

  Future<void> getBrands() async {
    emit(BrandLoading());
    final result = await homeRepo.getBrands();
    result.fold(
      (failure) => emit(BrandFailure(failure)),
      (brands) => emit(BrandSuccess(brands)),
    );
  }
}