import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ineventory/core/common/show_snackbar.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/get_products/get_products_bloc.dart';
import 'package:simple_ineventory/presentation/bloc/update_product/update_product_bloc.dart';
import 'package:simple_ineventory/presentation/pages/home_page.dart';
import 'package:simple_ineventory/presentation/widgets/category_bottom_sheet.dart';
import 'package:simple_ineventory/presentation/widgets/my_text_field.dart';

class AddProductPage extends StatefulWidget {
  static const routeName = 'add-product-page';
  static const routePath = '/add-product';
  final Map<String, dynamic>? extra;
  const AddProductPage({super.key, this.extra});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productCategoryController =
      TextEditingController();
  final TextEditingController productGroupController = TextEditingController();
  final TextEditingController productStockController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final List<String> productGroups = [
    'Mudah Pecah',
    'Tahan Banting',
    'Tahan Lama',
    'Tidak Tahan Lama',
    'Padat',
    'Cair'
  ];
  String? selectedProductGroup;

  final formKey = GlobalKey<FormState>();
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();

    final extra = widget.extra;

    if (extra != null && extra['update'] == 'update-page') {
      productNameController.text = extra['name'] ?? '';
      productCategoryController.text = extra['category_name'];
      productGroupController.text = extra['group'] ?? '';
      productStockController.text = extra['stock']?.toString() ?? '';
      productPriceController.text = extra['price']?.toString() ?? '';
      selectedCategoryId = extra['category_id'];
      selectedProductGroup = extra['group'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.extra!['update'] == 'update-page'
              ? 'Edit Barang'
              : 'Tambah Barang',
          style: textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddProductBloc, AddProductState>(
            listener: (context, state) {
              if (state is AddProductFailure) {
                showSnackBar(context, state.message);
              }
              if (state is AddProductSuccess) {
                showSnackBar(context, state.message);
                context.read<GetProductsBloc>().add(OnGetProducts());
                context.pop(HomePage.routePath);
              }
            },
          ),
          BlocListener<UpdateProductBloc, UpdateProductState>(
            listener: (context, state) {
              if (state is UpdateProductFailure) {
                showSnackBar(context, state.message);
              }
              if (state is UpdateProductSuccess) {
                showSnackBar(context, state.message);
                context.pop();
                context.read<GetProductsBloc>().add(OnGetProducts());
                context.pop(HomePage.routePath);
              }
            },
          ),
        ],
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: [
              MyTextField(
                label: 'Nama Barang *',
                hintText: 'Masukan nama barang . . .',
                controller: productNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Gap(16),
              MyTextField(
                label: 'Kategori Barang *',
                hintText: 'Pilih kategori barang . . .',
                controller: productCategoryController,
                isReadOnly: true,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => CategoryBottomSheet(
                      onSelected: (category) {
                        productCategoryController.text = category.name;
                        selectedCategoryId = category.id;
                      },
                    ),
                  );
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kategori barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Gap(16),
              Text(
                'Kelompok*',
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
              ),
              Gap(8),
              DropdownButtonFormField<String>(
                value: selectedProductGroup,
                isDense: true,
                items: productGroups
                    .map((group) => DropdownMenuItem(
                          value: group,
                          child: Text(
                            group,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProductGroup = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Pilih kelompok barang . . .',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kelompok barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Gap(16),
              MyTextField(
                label: 'Stok *',
                hintText: 'Masukan stok . . .',
                controller: productStockController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Stok barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Gap(16),
              MyTextField(
                label: 'Harga *',
                hintText: 'Masukan harga . . .',
                controller: productPriceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga barang tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ElevatedButton(
          onPressed: () {
            final isUpdate = widget.extra?['update'] == 'update-page';

            if (formKey.currentState!.validate() &&
                selectedCategoryId != null) {
              final product = Product(
                id: widget.extra?['id'],
                name: productNameController.text,
                cateogryId: selectedCategoryId!,
                group: selectedProductGroup.toString(),
                stock: int.parse(productStockController.text),
                price: int.parse(productPriceController.text),
              );

              if (isUpdate) {
                context
                    .read<UpdateProductBloc>()
                    .add(OnUpdateProduct(product: product));
              } else {
                context.read<AddProductBloc>().add(
                      OnAddProduct(
                        productName: product.name,
                        productCategoryId: product.cateogryId,
                        productStock: product.stock,
                        productGroup: product.group,
                        productPrice: product.price,
                      ),
                    );
              }
            } else if (selectedCategoryId == null) {
              showSnackBar(context, 'Isi semua');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.primaryColor,
          ),
          child: Text(
            widget.extra!['update'] == 'update-page'
                ? 'Edit Barang'
                : 'Tambah Barang',
            style: textTheme.bodyLarge!.copyWith(
              color: AppPallete.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
