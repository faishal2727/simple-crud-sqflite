part of 'detail_product_bloc.dart';

@immutable
sealed class DetailProductState {}

final class DetailProductInitial extends DetailProductState {}

final class DetailProductLoading extends DetailProductState {}

final class DetailProductSuccess extends DetailProductState {
  final DetailProduct detailProduct;

  DetailProductSuccess({required this.detailProduct});
}

final class DetailProductFailure extends DetailProductState {
  final String message;

  DetailProductFailure({required this.message});
}
