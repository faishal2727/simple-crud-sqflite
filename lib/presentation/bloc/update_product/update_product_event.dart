part of 'update_product_bloc.dart';

@immutable
sealed class UpdateProductEvent {}

final class OnUpdateProduct extends UpdateProductEvent {
  final Product product;

  OnUpdateProduct({required this.product});
}
