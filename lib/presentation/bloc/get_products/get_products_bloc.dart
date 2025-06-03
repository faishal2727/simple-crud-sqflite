import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/usecase/get_products.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final GetProducts _getProducts;
  GetProductsBloc({required GetProducts getProducts})
      : _getProducts = getProducts,
        super(GetProductsInitial()) {
    on<OnGetProducts>(_onGetProduts);
  }

  void _onGetProduts(OnGetProducts event, Emitter emit) async {
    emit(GetProductsLoading());
    final result = await _getProducts.execute();

    result.fold(
      (l) => emit(GetProductsFailure(message: l.message)),
      (r) {
        if (r.isEmpty) {
          emit(GetProductsEmpty());
        } else {
          emit(GetProductsSuccess(products: r));
        }
      },
    );
  }
}
