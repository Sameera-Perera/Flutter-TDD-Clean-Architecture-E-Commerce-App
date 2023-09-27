import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/category/category.dart';
import '../../../domain/usecases/product/get_product_usecase.dart';

class FilterCubit extends Cubit<FilterProductParams> {
  final TextEditingController searchController = TextEditingController();
  FilterCubit() : super(const FilterProductParams());

  void update({
    String? keyword,
    List<Category>? categories,
    Category? category,
  }) {
    List<Category> updatedCategories = [];
    if (category != null) {
      updatedCategories.add(category);
    } else if (categories != null) {
      updatedCategories.addAll(categories);
    } else {
      updatedCategories.addAll(state.categories);
    }
    emit(FilterProductParams(
      keyword: keyword ?? state.keyword,
      categories: updatedCategories,
    ));
  }

  void updateCategory({
    required Category category,
  }) {
    List<Category> updatedCategories = [];
    updatedCategories.addAll(state.categories);
    if (updatedCategories.contains(category)) {
      updatedCategories.remove(category);
    } else {
      updatedCategories.add(category);
    }
    emit(state.copyWith(
      categories: updatedCategories,
    ));
  }

  void updateRange(double min, double max) => emit(state.copyWith(
        minPrice: min,
        maxPrice: max,
      ));

  int getFiltersCount() {
    int count = 0;
    count = (state.categories.length) + count;
    count = count + ((state.minPrice!=0 || state.maxPrice!=10000)? 1 : 0);
    return count;
  }

  void reset() => emit(const FilterProductParams());
}
