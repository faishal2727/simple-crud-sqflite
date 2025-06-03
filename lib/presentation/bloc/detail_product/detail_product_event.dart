part of 'detail_product_bloc.dart';

@immutable
sealed class DetailProductEvent {}

final class OnDetailProduct extends DetailProductEvent {
  final int id;

  OnDetailProduct({required this.id});
}
