import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:simple_ineventory/core/common/idr_formatter.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';
import 'package:simple_ineventory/data/model/product.dart';
import 'package:simple_ineventory/presentation/cubit/added_products_cubit.dart';

class CardProductCheck extends StatelessWidget {
  final Product product;
  const CardProductCheck({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AddedProductsCubit, List<Product>>(
      builder: (context, selected) {
        final isChecked =
            context.read<AddedProductsCubit>().isSelected(product);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: AppPallete.grey,
              ),
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,
                activeColor: AppPallete.primaryColor,
                value: isChecked,
                onChanged: (_) {
                  if (isChecked) {
                    context.read<AddedProductsCubit>().deleteProduct(product);
                  } else {
                    context.read<AddedProductsCubit>().addProduct(product);
                  }
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      "Stok: ${product.stock}",
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppPallete.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                idrFormatter.format(product.price),
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
