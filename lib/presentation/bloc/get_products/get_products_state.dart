part of 'get_products_bloc.dart';

@immutable
sealed class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsEmpty extends GetProductsState {}

final class GetProductsSuccess extends GetProductsState {
  final List<Product> products;

  GetProductsSuccess({required this.products});
}

final class GetProductsFailure extends GetProductsState {
  final String message;

  GetProductsFailure({required this.message});
}
