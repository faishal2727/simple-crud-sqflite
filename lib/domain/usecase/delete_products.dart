import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

class DeleteProducts {
  final ProductRepository productRepository;

  DeleteProducts(this.productRepository);

  Future<Either<Failure, String>> execute(List<int> id) async {
    return await productRepository.deleteProducts(id);
  }
}
