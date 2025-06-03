import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_ineventory/domain/usecase/delete_products.dart';

part 'delete_products_event.dart';
part 'delete_products_state.dart';

class DeleteProductsBloc
    extends Bloc<DeleteProductsEvent, DeleteProductsState> {
  final DeleteProducts _deleteProducts;
  DeleteProductsBloc({required DeleteProducts deleteProducts})
      : _deleteProducts = deleteProducts,
        super(DeleteProductsInitial()) {
    on<OnDeleteProducts>(_onDeleteProducts);
  }

  void _onDeleteProducts(OnDeleteProducts event, Emitter emit) async {
    emit(DeleteProductsLoading());
    final result = await _deleteProducts.execute(event.id);
    result.fold(
      (l) => emit(DeleteProductsFailure(message: l.message)),
      (r) => emit(DeleteProductsSuccess(message: r)),
    );
  }
}
