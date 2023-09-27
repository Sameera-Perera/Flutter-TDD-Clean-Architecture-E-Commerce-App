import 'package:eshop/presentation/blocs/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../../blocs/category/category_bloc.dart';
import '../../../../blocs/filter/filter_cubit.dart';
import '../../../../widgets/input_form_button.dart';
import '../../../../widgets/input_range_slider.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FilterCubit>().reset();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 10,
            ),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, categoryState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryState.categories.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemBuilder: (context, index) =>
                    Row(
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
                                  .contains(categoryState.categories[index]) ||
                                  filterState.categories.isEmpty,
                              onChanged: (bool? value) {
                                context.read<FilterCubit>().updateCategory(
                                    category: categoryState.categories[index]);
                              },
                            );
                          },
                        )
                      ],
                    ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Price Range",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<FilterCubit, FilterProductParams>(
            builder: (context, state) {
              return RangeSliderExample(
                initMin: state.minPrice,
                initMax: state.maxPrice,
              );
            },
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Builder(builder: (context) {
            return InputFormButton(
              color: Colors.black87,
              onClick: () {
                context
                    .read<ProductBloc>()
                    .add(GetProducts(context
                    .read<FilterCubit>()
                    .state));
                Navigator.of(context).pop();
              },
              titleText: 'Continue',
            );
          }),
        ),
      ),
    );
  }
}
