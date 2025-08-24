// lib/features/home/data/repos/home_repo.dart
import 'package:dartz/dartz.dart';
import 'package:marketiapp/core/api/api_consumer.dart';
import 'package:marketiapp/core/errors/error_model.dart';
import 'package:marketiapp/core/errors/exceptions.dart';
import 'package:marketiapp/core/errors/failure.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_model.dart';
import 'package:marketiapp/features/Home/data/models/Products/product_response.dart';
import 'package:marketiapp/features/home/data/models/categories/categories_response.dart';
import 'package:marketiapp/features/home/data/models/categories/category_names_response.dart';
import 'package:marketiapp/features/home/data/models/brand/brands_response.dart';
import '../../../../core/api/end_points.dart';

class HomeRepo {
  final ApiConsumer api;
  HomeRepo({required this.api});

  // Get category names only
  Future<Either<Failure, CategoryNamesResponse>> getCategoryNames() async {
    try {
      final response = await api.get(EndPoints.categorynames);
      return Right(CategoryNamesResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Get categories with full details
  Future<Either<Failure, CategoriesResponse>> getCategories() async {
    try {
      final response = await api.get(EndPoints.categories);
      return Right(CategoriesResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Get brands
  Future<Either<Failure, BrandsResponse>> getBrands() async {
    try {
      final response = await api.get(EndPoints.brands);
      return Right(BrandsResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Get products with pagination
  Future<Either<Failure, ProductsResponse>> getProducts({
    int skip = 0,
    int limit = 10,
    String? sortBy,
    String? order,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'skip': skip,
        'limit': limit,
      };
      
      if (sortBy != null) queryParams['sortBy'] = sortBy;
      if (order != null) queryParams['order'] = order;
      
      final response = await api.get(
        EndPoints.products,
        queryParameters: queryParams,
      );
      return Right(ProductsResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Get products by category
  Future<Either<Failure, ProductsResponse>> getProductsByCategory(
    String category, {
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await api.get(
        EndPoints.productbycategory,
      );
      return Right(ProductsResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

  // Get products by brand
  Future<Either<Failure, ProductsResponse>> getProductsByBrand(
    String brand, {
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await api.get(
        EndPoints.productbybrand,
      );
      return Right(ProductsResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel));
    } catch (e) {
      return Left(UnknownFailure(ErrorModel(e.toString())));
    }
  }

}