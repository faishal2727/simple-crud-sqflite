// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';
import 'package:simple_ineventory/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_products/get_products_bloc.dart';
import 'package:simple_ineventory/presentation/pages/add_product_page.dart';
import 'package:simple_ineventory/presentation/pages/delete_product_page.dart';
import 'package:simple_ineventory/presentation/pages/search_product_page.dart';
import 'package:simple_ineventory/presentation/widgets/card_product.dart';
import 'package:simple_ineventory/presentation/widgets/product_detail_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home-page';
  static const routePath = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<GetProductsBloc>().add(OnGetProducts());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Stok Barang',
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(SearchProductPage.routeName);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<GetProductsBloc, GetProductsState>(
              builder: (context, state) {
                if (state is GetProductsEmpty) {
                  return Center(child: Text('Data Produk Kosong'));
                }
                if (state is GetProductsFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is GetProductsSuccess) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${state.products.length} Data ditampilkan"),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(DeleteProductPage.routeName);
                              },
                              child: Text(
                                'Edit Data',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppPallete.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<DetailProductBloc>()
                                    .add(OnDetailProduct(id: product.id ?? 0));
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (context) =>
                                      ProductDetailBottomSheet(
                                    product: product,
                                    id: product.id ?? 0,
                                  ),
                                );
                              },
                              child: CardProduct(product: product),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(AddProductPage.routeName,
              extra: {'add': 'add-product'});
        },
        label: Text(
          'Barang',
          style: textTheme.bodyLarge!.copyWith(color: AppPallete.white),
        ),
        icon: Icon(Icons.add, color: AppPallete.white),
        backgroundColor: AppPallete.primaryColor,
      ),
    );
  }
}

