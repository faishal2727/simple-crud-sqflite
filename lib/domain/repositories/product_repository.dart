import 'package:dartz/dartz.dart';

import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/model/category.dart';
import 'package:simple_ineventory/data/model/detail_product.dart';
import 'package:simple_ineventory/data/model/product.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, String>> addProduct({
    required String productName,
    required int productCategoryId,
    required int productStock,
    required String productGroup,
    required int productPrice,
  });
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, String>> removeProduct(Product product);
  Future<Either<Failure, String>> updateProduct(Product product);
  Future<Either<Failure, List<Product>>> seacrhProduct(String query);
  Future<Either<Failure, DetailProduct>> getProductWithCategoryName(int id);
  Future<Either<Failure, String>> deleteProducts(List<int> id);
  Future<Either<Failure, List<Category>>> getCategories();
}
