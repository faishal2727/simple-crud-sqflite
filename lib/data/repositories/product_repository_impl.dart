import 'package:dartz/dartz.dart';
import 'package:simple_ineventory/core/errors/exception.dart';
import 'package:simple_ineventory/core/errors/failure.dart';
import 'package:simple_ineventory/data/datasources/product_local_data_source.dart';
import 'package:simple_ineventory/data/model/detail_product.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';

import '../model/category.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;

  ProductRepositoryImpl({required this.productLocalDataSource});

  @override
  Future<Either<Failure, String>> addProduct({
    required String productName,
    required int productCategoryId,
    required int productStock,
    required String productGroup,
    required int productPrice,
  }) async {
    try {
      final product = Product(
        name: productName,
        cateogryId: productCategoryId,
        stock: productStock,
        group: productGroup,
        price: productPrice,
      );
      final result = await productLocalDataSource.insertProduct(product);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final result = await productLocalDataSource.getProducts();
    return Right(result.map((data) => data).toList());
  }

  @override
  Future<Either<Failure, String>> removeProduct(Product product) async {
    try {
      final result = await productLocalDataSource.removeProduct(product);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    final result = await productLocalDataSource.getCategories();
    return Right(result.map((data) => data).toList());
  }

  @override
  Future<Either<Failure, String>> updateProduct(Product product) async {
    try {
      final result = await productLocalDataSource.updateProduct(product);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, DetailProduct>> getProductWithCategoryName(
      int id) async {
    try {
      final result =
          await productLocalDataSource.getProductsWithCategoryName(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> seacrhProduct(String query) async {
    final result = await productLocalDataSource.searchProduct(query);
    return Right(result.map((data) => data).toList());
  }

  @override
  Future<Either<Failure, String>> deleteProducts(List<int> id) async {
    try {
      final result = await productLocalDataSource.deleteProducts(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
