import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:eshop/presentation/blocs/category/category_bloc.dart';
import 'package:eshop/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              return Expanded(
                child: ListView.builder(
                  itemCount: categoryState.categories.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(
                        categoryState.categories[index].name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      BlocBuilder<FilterCubit, FilterProductParams>(
                        builder: (context, filterState) {
                          return Checkbox(
                            value: filterState.categories
                                .contains(categoryState.categories[index]),
                            onChanged: (bool? value) {
                              context.read<FilterCubit>().updateCategory(
                                  category: categoryState.categories[index]);
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
