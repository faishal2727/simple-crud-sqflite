part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductSuccess extends UpdateProductState {
  final String message;

  UpdateProductSuccess({required this.message});
}

final class UpdateProductFailure extends UpdateProductState {
  final String message;

  UpdateProductFailure({required this.message});
}
