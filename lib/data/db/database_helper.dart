// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblProduct = 'product';
  static const String _tblCategory = 'category';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/inventory.db';

    var db = await openDatabase(databasePath, version: 4, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tblProduct (
          id INTEGER PRIMARY KEY,
          name TEXT,
          category INTEGER,
          stock INTEGER,
          product_group TEXT,
          price INTEGER
        );
    ''');

    await db.execute('''
    CREATE TABLE $_tblCategory (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

    await db.insert(_tblCategory, {'id': 1, 'name': 'Elektronik'});
    await db.insert(_tblCategory, {'id': 2, 'name': 'Pakaian'});
    await db.insert(_tblCategory, {'id': 3, 'name': 'Makanan'});
  }

  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db!.insert(_tblProduct, product.toJson());
  }

  Future<int> updateProduct(Product product) async {
    final db = await database;

    if (product.id == null) {
      throw Exception('ID produk tidak boleh null saat update');
    }

    final json = product.toJson();

    return await db!.update(
      _tblProduct,
      json,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(_tblProduct);
    return result;
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(_tblCategory);
    return result;
  }

  Future<List<Map<String, dynamic>>> searchProductsByName(
      String keyword) async {
    final db = await database;
    final result = await db!.query(
      _tblProduct,
      where: 'name LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getProductsWithCategoryName(int id) async {
    final db = await database;
    final result = await db!.rawQuery('''
    SELECT p.id, p.name, p.stock, p.product_group, p.price, 
           p.category as category_id, c.name as category_name
    FROM $_tblProduct p
    LEFT JOIN $_tblCategory c ON p.category = c.id
    WHERE p.id = ?
  ''', [id]);

    debugPrint('Query result for product id $id: $result');
    if (result.isNotEmpty) {
      debugPrint('First item: ${result.first}');
    } else {
      debugPrint('No product found for id $id');
    }

    return result;
  }

  Future<int> removeProductsByIds(List<int> ids) async {
    final db = await database;
    if (ids.isEmpty) return 0;

    final placeholders = List.filled(ids.length, '?').join(', ');
    return await db!.delete(
      _tblProduct,
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
  }

  Future<int> removeProduct(Product product) async {
    final db = await database;
    return await db!.delete(
      _tblProduct,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
