part of 'add_product_bloc.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final String message;

  AddProductSuccess({required this.message});
}

final class AddProductFailure extends AddProductState {
  final String message;

  AddProductFailure({required this.message});
}
