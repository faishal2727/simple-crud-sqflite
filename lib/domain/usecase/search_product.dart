import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class SearchProduct {
  final ProductRepository productRepository;

  SearchProduct(this.productRepository);

  Future<Either<Failure, List<Product>>> execute(String query) async {
    return await productRepository.seacrhProduct(query);
  }
}