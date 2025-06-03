import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class AddProduct {
  final ProductRepository productRepository;

  AddProduct(this.productRepository);

  Future<Either<Failure, String>> execute(
    String productName,
    int productCategoryId,
    int productStock,
    String productGroup,
    int productPrice,
  ) async {
    return await productRepository.addProduct(
      productName: productName,
      productCategoryId: productCategoryId,
      productStock: productStock,
      productGroup: productGroup,
      productPrice: productPrice,
    );
  }
}
