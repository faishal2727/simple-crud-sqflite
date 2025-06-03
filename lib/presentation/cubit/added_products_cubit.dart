import 'package:bloc/bloc.dart';
import 'package:simple_ineventory/data/model/product.dart';

class AddedProductsCubit extends Cubit<List<Product>> {
  AddedProductsCubit() : super([]);

  void addProduct(Product product) {
    final alreadyAdded = state.any((p) => p.id == product.id);
    if (!alreadyAdded) {
      emit([...state, product]);
    }
  }

  void deleteProduct(Product product) {
    emit(state.where((p) => p.id != product.id).toList());
  }

  void selectAll(List<Product> allProducts) {
    emit(List.from(allProducts));
  }

  void unselectAll() {
    emit([]);
  }

  bool isSelected(Product product) {
    return state.any((p) => p.id == product.id);
  }

  bool isAllSelected(List<Product> allProducts) {
    return allProducts.every((p) => state.any((s) => s.id == p.id));
  }
}
