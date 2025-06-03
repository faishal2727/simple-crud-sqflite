part of 'delete_products_bloc.dart';

@immutable
sealed class DeleteProductsState {}

final class DeleteProductsInitial extends DeleteProductsState {}

final class DeleteProductsLoading extends DeleteProductsState {}

final class DeleteProductsSuccess extends DeleteProductsState {
  final String message;

  DeleteProductsSuccess({required this.message});
}

final class DeleteProductsFailure extends DeleteProductsState {
  final String message;

  DeleteProductsFailure({required this.message});
}
