part of 'get_categories_bloc.dart';

@immutable
sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

final class GetCategoriesEmpty extends GetCategoriesState {}

final class GetCategoriesSuccess extends GetCategoriesState {
  final List<Category> categories;

  GetCategoriesSuccess({required this.categories});
}

final class GetCategoriesFailure extends GetCategoriesState {
  final String message;

  GetCategoriesFailure({required this.message});
}
