part of 'add_product_bloc.dart';

@immutable
sealed class AddProductEvent {}

final class OnAddProduct extends AddProductEvent {
  final String productName;
  final int productCategoryId;
  final int productStock;
  final String productGroup;
  final int productPrice;

  OnAddProduct({
    required this.productName,
    required this.productCategoryId,
    required this.productStock,
    required this.productGroup,
    required this.productPrice,
  });
}
