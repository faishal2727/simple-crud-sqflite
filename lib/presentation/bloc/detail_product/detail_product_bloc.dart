import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_ineventory/data/model/detail_product.dart';
import 'package:simple_ineventory/domain/usecase/get_product_with_category_name.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final GetProductWithCategoryName _getProductWithCategoryName;
  DetailProductBloc({
    required GetProductWithCategoryName getProductsWithCategoryName,
  })  : _getProductWithCategoryName = getProductsWithCategoryName,
        super(DetailProductInitial()) {
    on<OnDetailProduct>(_onGetDetailProduct);
  }

  void _onGetDetailProduct(OnDetailProduct event, Emitter emit) async {
    emit(DetailProductLoading());

    final result = await _getProductWithCategoryName.execute(event.id);

    result.fold(
      (l) => emit(DetailProductFailure(message: l.message)),
      (r) => emit(DetailProductSuccess(detailProduct: r)),
    );
  }
}
