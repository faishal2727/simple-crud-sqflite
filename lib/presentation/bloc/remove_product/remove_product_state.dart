part of 'remove_product_bloc.dart';

@immutable
sealed class RemoveProductState {}

final class RemoveProductInitial extends RemoveProductState {}

final class RemoveProductLoading extends RemoveProductState {}

final class RemoveProductSuccess extends RemoveProductState {
  final String message;

  RemoveProductSuccess({required this.message});
}

final class RemoveProductFailure extends RemoveProductState {
  final String message;

  RemoveProductFailure({required this.message});
}
