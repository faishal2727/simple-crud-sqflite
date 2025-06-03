import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:simple_ineventory/presentation/bloc/search_product/search_product_bloc.dart';
import 'package:simple_ineventory/presentation/widgets/card_product.dart';
import 'package:simple_ineventory/presentation/widgets/my_text_field.dart';

class SearchProductPage extends StatefulWidget {
  static const routeName = 'search-product-page';
  static const routePath = '/search-product';
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Produk'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyTextField(
              label: 'Cari',
              hintText: 'Cari produk . . .',
              controller: productNameController,
              onChanged: (query) {
                context
                    .read<SearchProductBloc>()
                    .add(OnSearchProduct(query: query));
              },
            ),
          ),
          const Gap(8),
          Expanded(
            child: BlocBuilder<SearchProductBloc, SearchProductState>(
              builder: (context, state) {
                if (state is SearchProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SearchProductEmpty) {
                  return const Center(child: Text('Data Kosong'));
                }
                if (state is SearchProductFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is SearchProductSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text("${state.product.length} Data cocok"),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.product.length,
                          itemBuilder: (context, index) {
                            return CardProduct(
                              product: state.product[index],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
