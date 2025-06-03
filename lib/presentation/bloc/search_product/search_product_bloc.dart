import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/usecase/search_product.dart';
import 'package:rxdart/rxdart.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProduct _searchProduct;
  SearchProductBloc({required SearchProduct searchProduct})
      : _searchProduct = searchProduct,
        super(SearchProductInitial()) {
    on<OnSearchProduct>(
      _onSearchProduct,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void _onSearchProduct(OnSearchProduct event, Emitter emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchProductEmpty());
      return;
    }
    emit(SearchProductLoading());
    final result = await _searchProduct.execute(event.query);
    result.fold(
      (l) => emit(SearchProductFailure(message: l.message)),
      (r) {
        if (r.isEmpty) {
          emit(SearchProductEmpty());
        } else {
          emit(SearchProductSuccess(product: r));
        }
      },
    );

    debounce(const Duration(milliseconds: 500));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
