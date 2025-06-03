part of 'init_dependencies.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  _initProduct();
  serviceLocator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}

void _initProduct() {
  serviceLocator
    ..registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(
        databaseHelper: serviceLocator(),
      ),
    )
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(
        productLocalDataSource: serviceLocator(),
      ),
    )
    ..registerFactory<AddProduct>(
      () => AddProduct(serviceLocator()),
    )
    ..registerFactory<GetProductWithCategoryName>(
      () => GetProductWithCategoryName(serviceLocator()),
    )
    ..registerFactory<RemoveProduct>(
      () => RemoveProduct(serviceLocator()),
    )
    ..registerFactory<GetCategories>(
      () => GetCategories(serviceLocator()),
    )
    ..registerFactory<UpdateProduct>(
      () => UpdateProduct(serviceLocator()),
    )
    ..registerFactory<SearchProduct>(
      () => SearchProduct(serviceLocator()),
    )
    ..registerFactory<DeleteProducts>(
      () => DeleteProducts(serviceLocator()),
    )
    ..registerFactory<GetProducts>(
      () => GetProducts(serviceLocator()),
    )
    ..registerLazySingleton(
      () => AddProductBloc(addProduct: serviceLocator()),
    )
    ..registerLazySingleton(
      () => RemoveProductBloc(removeProduct: serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetCategoriesBloc(getCategories: serviceLocator()),
    )
    ..registerLazySingleton(
      () => UpdateProductBloc(updateProduct: serviceLocator()),
    )
    ..registerLazySingleton(
      () => DetailProductBloc(getProductsWithCategoryName: serviceLocator()),
    )
    ..registerLazySingleton(
      () => SearchProductBloc(searchProduct: serviceLocator()),
    )
    ..registerLazySingleton(
      () => AddedProductsCubit(),
    )
    ..registerLazySingleton(
      () => DeleteProductsBloc(deleteProducts: serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetProductsBloc(getProducts: serviceLocator()),
    );
}
