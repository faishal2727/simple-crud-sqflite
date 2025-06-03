import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/model/detail_product.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class GetProductWithCategoryName {
  final ProductRepository productRepository;

  GetProductWithCategoryName(this.productRepository);

  Future<Either<Failure, DetailProduct>> execute(int id) async {
    return await productRepository.getProductWithCategoryName(id);
  }
}
