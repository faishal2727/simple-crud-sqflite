import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ineventory/core/common/idr_formatter.dart';
import 'package:simple_ineventory/core/common/show_snackbar.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_products/get_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/remove_product/remove_product_bloc.dart';
import 'package:simple_ineventory/presentation/pages/add_product_page.dart';

class ProductDetailBottomSheet extends StatelessWidget {
  final Product product;
  final int id;

  const ProductDetailBottomSheet({
    super.key,
    required this.id,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        if (state is DetailProductLoading) {
          return CircularProgressIndicator();
        }
        if (state is DetailProductFailure) {
          return Text(state.message);
        }
        if (state is DetailProductSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppPallete.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Barang',
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.detailProduct.name,
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kategori',
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.detailProduct.categoryName.toString(),
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kelompok',
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.detailProduct.group,
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Stok',
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.detailProduct.stock.toString(),
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppPallete.strokeLine,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Harga',
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          idrFormatter.format(
                            state.detailProduct.price,
                          ),
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text(
                                    'Apakah kamu yakin ingin menghapus barang ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(context),
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pop(context);

                                      context.read<RemoveProductBloc>().add(
                                          OnRemoveProduct(product: product));
                                      context
                                          .read<GetProductsBloc>()
                                          .add(OnGetProducts());
                                      context.pop(context);

                                      showSnackBar(
                                        context,
                                        'Berhasil hapus data',
                                      );
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                      ),
                      Gap(8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(
                              AddProductPage.routeName,
                              extra: {
                                'update': 'update-page',
                                'id': product.id,
                                'name': product.name,
                                'stock': product.stock,
                                'category_id': state.detailProduct.cateogryId,
                                'category_name':
                                    state.detailProduct.categoryName,
                                'group': product.group,
                                'price': product.price,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            backgroundColor: AppPallete.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Edit Barang',
                            style: textTheme.bodyLarge!.copyWith(
                              color: AppPallete.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
