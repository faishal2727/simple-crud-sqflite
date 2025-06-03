import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/usecase/remove_product.dart';

part 'remove_product_event.dart';
part 'remove_product_state.dart';

class RemoveProductBloc extends Bloc<RemoveProductEvent, RemoveProductState> {
  final RemoveProduct _removeProduct;
  RemoveProductBloc({required RemoveProduct removeProduct})
      : _removeProduct = removeProduct,
        super(RemoveProductInitial()) {
    on<OnRemoveProduct>(_onRemoveProduct);
  }

  void _onRemoveProduct(OnRemoveProduct event, Emitter emit) async {
    emit(RemoveProductLoading());
    final result = await _removeProduct.execute(event.product);
    result.fold(
      (l) => emit(RemoveProductFailure(message: l.message)),
      (r) => emit(RemoveProductSuccess(message: r)),
    );
  }
}
