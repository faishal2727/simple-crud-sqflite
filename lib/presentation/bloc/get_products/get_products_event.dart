part of 'get_products_bloc.dart';

@immutable
sealed class GetProductsEvent {}

final class OnGetProducts extends GetProductsEvent {}
