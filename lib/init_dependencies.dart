
import 'package:get_it/get_it.dart';
import 'package:simple_ineventory/data/datasources/product_local_data_source.dart';
import 'package:simple_ineventory/data/db/database_helper.dart';
import 'package:simple_ineventory/data/repositories/product_repository_impl.dart';
import 'package:simple_ineventory/domain/repositories/product_repository.dart';
import 'package:simple_ineventory/domain/usecase/add_product.dart';
import 'package:simple_ineventory/domain/usecase/delete_products.dart';
import 'package:simple_ineventory/domain/usecase/get_categories.dart';
import 'package:simple_ineventory/domain/usecase/get_product_with_category_name.dart';
import 'package:simple_ineventory/domain/usecase/get_products.dart';
import 'package:simple_ineventory/domain/usecase/remove_product.dart';
import 'package:simple_ineventory/domain/usecase/search_product.dart';
import 'package:simple_ineventory/domain/usecase/update_product.dart';
import 'package:simple_ineventory/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/delete_products/delete_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_categories/get_categories_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_products/get_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/remove_product/remove_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/search_product/search_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/update_product/update_product_bloc.dart';
import 'package:simple_ineventory/presentation/cubit/added_products_cubit.dart';

part 'init_dependencies.main.dart';