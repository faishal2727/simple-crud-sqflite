import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_ineventory/domain/usecase/add_product.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProduct _addProduct;
  AddProductBloc({
    required AddProduct addProduct,
  })  : _addProduct = addProduct,
        super(AddProductInitial()) {
    on<OnAddProduct>(_onAddProduct);
  }
  void _onAddProduct(OnAddProduct event, Emitter emit) async {
    emit(AddProductLoading());
    final result = await _addProduct.execute(
      event.productName,
      event.productCategoryId,
      event.productStock,
      event.productGroup,
      event.productPrice,
    );
    result.fold(
      (l) => emit(AddProductFailure(message: l.message)),
      (r) => emit(AddProductSuccess(message: r)),
    );
  }
}
