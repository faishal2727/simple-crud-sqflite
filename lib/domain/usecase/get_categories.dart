import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/model/category.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class GetCategories {
  final ProductRepository productRepository;

  GetCategories(this.productRepository);

  Future<Either<Failure, List<Category>>> execute() async {
    return await productRepository.getCategories();
  }
}
