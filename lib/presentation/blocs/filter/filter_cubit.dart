import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/category/category.dart';
import '../../../domain/usecases/product/get_product_usecase.dart';

class FilterCubit extends Cubit<FilterProductParams> {
  final TextEditingController searchController = TextEditingController();
  FilterCubit() : super(const FilterProductParams());

  void update({
    String? keyword,
    Category? category,
  }) =>
      emit(FilterProductParams(
        keyword: keyword ?? state.keyword,
        category: category ?? state.category,
      ));

  int getFiltersCount() {
    int count = 0;
    count = (state.category != null ? 1 : 0) + count;
    return count;
  }
}
