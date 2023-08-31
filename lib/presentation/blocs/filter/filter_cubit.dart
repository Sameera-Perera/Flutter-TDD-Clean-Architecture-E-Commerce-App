import 'package:bloc/bloc.dart';

import '../../../domain/usecases/product/get_product_usecase.dart';

class FilterCubit extends Cubit<FilterProductParams> {
  FilterCubit() : super(const FilterProductParams());

  void update({String? keyword}) => emit(FilterProductParams(
        keyword: keyword ?? state.keyword,
      ));
}
