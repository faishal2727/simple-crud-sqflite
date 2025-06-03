import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ineventory/core/common/show_snackbar.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/presentation/bloc/delete_products/delete_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_products/get_products_bloc.dart';
import 'package:simple_ineventory/presentation/cubit/added_products_cubit.dart';
import 'package:simple_ineventory/presentation/widgets/card_product_check.dart';

class DeleteProductPage extends StatefulWidget {
  static const routeName = 'delete-product-page';
  static const routePath = '/delete-product';

  const DeleteProductPage({super.key});

  @override
  State<DeleteProductPage> createState() => _DeleteProductPageState();
}

class _DeleteProductPageState extends State<DeleteProductPage> {
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
      ),
      body: Column(
        children: [
          BlocBuilder<GetProductsBloc, GetProductsState>(
            builder: (context, state) {
              if (state is GetProductsEmpty) {
                return Text('Data Produk Kosong');
              }
              if (state is GetProductsFailure) {
                return Text(state.message);
              }
              if (state is GetProductsSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return CardProductCheck(product: product);
                  },
                );
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<GetProductsBloc, GetProductsState>(
              builder: (context, state) {
                if (state is GetProductsSuccess) {
                  final allProducts = state.products;
                  return BlocBuilder<AddedProductsCubit, List<Product>>(
                    builder: (context, selectedProducts) {
                      final isAllSelected = context
                          .read<AddedProductsCubit>()
                          .isAllSelected(allProducts);

                      return Row(
                        children: [
                          Checkbox(
                            value: isAllSelected,
                            onChanged: (value) {
                              if (value == true) {
                                context
                                    .read<AddedProductsCubit>()
                                    .selectAll(allProducts);
                              } else {
                                context
                                    .read<AddedProductsCubit>()
                                    .unselectAll();
                              }
                            },
                          ),
                          const Text('Pilih Semua'),
                        ],
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Konfirmasi'),
                    content:
                        Text('Apakah kamu yakin ingin menghapus barang ini?'),
                    actions: [
                      TextButton(
                        onPressed: () => context.pop(context),
                        child: Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop(context);

                          final selectedProducts =
                              context.read<AddedProductsCubit>().state;
                          final ids = selectedProducts
                              .map((e) => e.id)
                              .whereType<int>()
                              .toList();

                          if (ids.isEmpty) {
                            showSnackBar(
                              context,
                              'Pilih produk yang ingin dihapus dulu',
                            );
                            return;
                          }

                          context
                              .read<DeleteProductsBloc>()
                              .add(OnDeleteProducts(id: ids));
                          context.read<GetProductsBloc>().add(OnGetProducts());
                          context.pop(context);
                          showSnackBar(context, 'Berhasil hapus data');
                        },
                        child: Text(
                          'Hapus',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.white,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                side: BorderSide(color: AppPallete.grey),
              ),
              child: Text(
                'Hapus Barang',
                style: textTheme.bodyLarge!.copyWith(
                  color: AppPallete.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
