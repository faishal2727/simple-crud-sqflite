import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_ineventory/core/common/idr_formatter.dart';
import 'package:simple_ineventory/core/themes/app_pallete.dart';
import 'package:simple_ineventory/data/model/product.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  const CardProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(8),
              Text(
                "Stok: ${product.stock.toString()}",
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppPallete.darkGrey,
                ),
              ),
            ],
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
  }
}
