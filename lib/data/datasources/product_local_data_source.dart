import 'package:flutter/material.dart';
import 'package:simple_ineventory/core/errors/exception.dart';
import 'package:simple_ineventory/data/db/database_helper.dart';
import 'package:simple_ineventory/data/model/detail_product.dart';
import 'package:simple_ineventory/data/model/product.dart';

import '../model/category.dart';

abstract class ProductLocalDataSource {
  Future<String> insertProduct(Product product);
  Future<List<Product>> getProducts();
  Future<String> removeProduct(Product product);
  Future<String> updateProduct(Product product);
  Future<DetailProduct> getProductsWithCategoryName(int id);
  Future<List<Product>> searchProduct(String query);
  Future<String> deleteProducts(List<int> id);
  Future<List<Category>> getCategories();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertProduct(Product product) async {
    try {
      await databaseHelper.insertProduct(product);
      return 'Success add product';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    final result = await databaseHelper.getProducts();
    return result.map((data) => Product.fromJson(data)).toList();
  }

  @override
  Future<String> removeProduct(Product product) async {
    try {
      await databaseHelper.removeProduct(product);
      return 'Success delete product';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    final result = await databaseHelper.getCategories();
    return result.map((data) => Category.fromJson(data)).toList();
  }

  @override
  Future<String> updateProduct(Product product) async {
    try {
      await databaseHelper.updateProduct(product);
      return 'Success update product';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<DetailProduct> getProductsWithCategoryName(int id) async {
    try {
      final result = await databaseHelper.getProductsWithCategoryName(id);

      debugPrint('getProductsWithCategoryName result: $result');

      if (result.isNotEmpty) {
        return DetailProduct.fromJson(result.first);
      } else {
        throw DatabaseException('Product not found');
      }
    } catch (e) {
      debugPrint('Error in getProductsWithCategoryName: $e');
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<Product>> searchProduct(String query) async {
    final result = await databaseHelper.searchProductsByName(query);
    return result.map((data) => Product.fromJson(data)).toList();
  }

  @override
  Future<String> deleteProducts(List<int> id) async {
     try {
      await databaseHelper.removeProductsByIds(id);
      return 'Success delete product';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
