import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository productRepository;

  UpdateProduct(this.productRepository);

  Future<Either<Failure, String>> execute(Product product) async {
    return await productRepository.updateProduct(product);
  }
}
