part of 'delete_products_bloc.dart';

@immutable
sealed class DeleteProductsEvent {}

final class OnDeleteProducts extends DeleteProductsEvent {
  final List<int> id;

  OnDeleteProducts({required this.id});
}
