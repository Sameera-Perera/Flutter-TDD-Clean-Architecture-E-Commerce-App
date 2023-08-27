import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/category/category.dart';
import '../../../domain/usecases/category/get_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoryUseCase _getCategoryUseCase;

  CategoryBloc(this._getCategoryUseCase) : super(const CategoryInitial(categories: [])) {
    on<GetCategories>(_onLoadCategories);
  }

  void _onLoadCategories(
      GetCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(const CategoryLoading(categories: []));
      final result = await _getCategoryUseCase(NoParams());
      result.fold(
        (failure) => emit(CategoryError(
          categories: state.categories,
          message: _mapFailureToMessage(failure),
        )),
        (categoryResponse) => emit(CategoryLoaded(
          categories: categoryResponse.categories,
        )),
      );
    } catch (e) {
      emit(CategoryError(
        categories: state.categories,
        message: e.toString(),
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
