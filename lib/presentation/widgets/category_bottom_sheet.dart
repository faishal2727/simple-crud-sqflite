
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ineventory/data/model/category.dart';
import 'package:simple_ineventory/presentation/bloc/get_categories/get_categories_bloc.dart';

class CategoryBottomSheet extends StatelessWidget {
  final void Function(Category category) onSelected;

  const CategoryBottomSheet({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<GetCategoriesBloc>()..add(OnGetCategories()),
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetCategoriesFailure) {
                return Center(child: Text(state.message));
              } else if (state is GetCategoriesSuccess) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return ListTile(
                      title: Text(category.name),
                      onTap: () {
                        onSelected(category);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              }
              return Center(child: Text('Tidak ada kategori.'));
            },
          );
        },
      ),
    );
  }
}
