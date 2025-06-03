import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository productRepository;

  GetProducts(this.productRepository);

  Future<Either<Failure, List<Product>>> execute() async {
    return await productRepository.getProducts();
  }
}
