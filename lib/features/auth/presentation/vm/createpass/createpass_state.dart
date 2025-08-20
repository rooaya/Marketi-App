// createpass_state.dart
part of 'createpass_cubit.dart';

@immutable
sealed class CreatepassState {}

final class CreatepassInitial extends CreatepassState {}

final class CreatepassLoading extends CreatepassState {}

final class CreatepassSuccess extends CreatepassState {}

final class CreatepassFailure extends CreatepassState {
  final String error;
  
  CreatepassFailure({required this.error});
}