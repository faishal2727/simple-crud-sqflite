import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ineventory/init_dependencies.dart';
import 'package:simple_ineventory/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/delete_products/delete_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_categories/get_categories_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_products/get_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/remove_product/remove_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/search_product/search_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/update_product/update_product_bloc.dart';
import 'package:simple_ineventory/presentation/cubit/added_products_cubit.dart';

get bloc => [
      BlocProvider(
        create: (context) => serviceLocator<AddProductBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<GetProductsBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<RemoveProductBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<GetCategoriesBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<UpdateProductBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<DetailProductBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<SearchProductBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<DeleteProductsBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AddedProductsCubit>(),
      ),
    ];
