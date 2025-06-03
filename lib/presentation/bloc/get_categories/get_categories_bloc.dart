import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_ineventory/data/model/category.dart';
import 'package:simple_ineventory/domain/usecase/get_categories.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final GetCategories _getCategories;
  GetCategoriesBloc({
    required GetCategories getCategories,
  })  : _getCategories = getCategories,
        super(GetCategoriesInitial()) {
    on<OnGetCategories>(_onGetCategories);
  }

  void _onGetCategories(OnGetCategories event, Emitter emit) async {
    emit(GetCategoriesLoading());
    final result = await _getCategories.execute();
    result.fold(
      (l) => emit(GetCategoriesFailure(message: l.message)),
      (r) {
        if (r.isEmpty) {
          emit(GetCategoriesEmpty());
        } else {
          emit(GetCategoriesSuccess(categories: r));
        }
      },
    );
  }
}
