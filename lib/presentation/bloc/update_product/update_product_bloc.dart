import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/usecase/update_product.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final UpdateProduct _updateProduct;
  UpdateProductBloc({required UpdateProduct updateProduct})
      : _updateProduct = updateProduct,
        super(
          UpdateProductInitial(),
        ) {
    on<OnUpdateProduct>(_onUpdateProduct);
  }

  void _onUpdateProduct(OnUpdateProduct event, Emitter emit) async {
    emit(UpdateProductLoading());
    final result = await _updateProduct.execute(event.product);
    result.fold(
      (l) => emit(UpdateProductFailure(message: l.message)),
      (r) => emit(UpdateProductSuccess(message: r)),
    );
  }
}
