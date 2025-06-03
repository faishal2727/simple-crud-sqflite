part of 'remove_product_bloc.dart';

@immutable
sealed class RemoveProductEvent {}

final class OnRemoveProduct extends RemoveProductEvent {
  final Product product;

  OnRemoveProduct({required this.product});
}
