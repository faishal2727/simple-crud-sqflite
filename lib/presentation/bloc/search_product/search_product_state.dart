part of 'search_product_bloc.dart';

@immutable
sealed class SearchProductState {}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductLoading extends SearchProductState {}

final class SearchProductEmpty extends SearchProductState {}

final class SearchProductSuccess extends SearchProductState {
  final List<Product> product;

  SearchProductSuccess({required this.product});
}

final class SearchProductFailure extends SearchProductState {
  final String message;

  SearchProductFailure({required this.message});
}
