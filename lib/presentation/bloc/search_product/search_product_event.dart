part of 'search_product_bloc.dart';

@immutable
sealed class SearchProductEvent {}

final class OnSearchProduct extends SearchProductEvent {
  final String query;

  OnSearchProduct({required this.query});
}
