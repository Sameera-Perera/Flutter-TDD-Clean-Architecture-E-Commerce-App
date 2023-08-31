import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/domain/usecases/category/get_cached_category_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/category/category.dart';
import '../../../domain/usecases/category/get_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase _getCategoryUseCase;
  final GetCachedCategoryUseCase _getCashedCategoryUseCase;

  CategoryBloc(this._getCategoryUseCase, this._getCashedCategoryUseCase)
      : super(const CategoryLoading(categories: [])) {
    on<GetCategories>(_onLoadCategories);
  }

  void _onLoadCategories(
      GetCategories event, Emitter<CategoryState> emit) async {
    try {
      ///Initial Category loading with minimal loading animation
      ///
      ///Cashed category
      emit(const CategoryLoading(categories: []));
      final cashedResult = await _getCashedCategoryUseCase(NoParams());
      cashedResult.fold(
        (failure) => (),
        (categoryResponse) => emit(CategoryCacheLoaded(
          categories: categoryResponse.categories,
        )),
      );
      ///Check remote data source to find categories
      ///Method will find and update if there any new category update from server
      ///Remote Category
      final result = await _getCategoryUseCase(NoParams());
      result.fold(
        (failure) => emit(CategoryError(
          categories: state.categories,
          failure: failure,
        )),
        (categoryResponse) => emit(CategoryLoaded(
          categories: categoryResponse.categories,
        )),
      );
    } catch (e) {
      emit(CategoryError(
        categories: state.categories,
        failure: ExceptionFailure(),
      ));
    }
  }
}
