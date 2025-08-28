// brand_state.dart
part of 'brand_cubit.dart';

@immutable
sealed class BrandState {}

final class BrandInitial extends BrandState {}

final class BrandLoading extends BrandState {}

final class BrandSuccess extends BrandState {
  final BrandsResponse brands;
  BrandSuccess(this.brands);
}

final class BrandFailure extends BrandState {
  final Failure failure;
  BrandFailure(this.failure);
}