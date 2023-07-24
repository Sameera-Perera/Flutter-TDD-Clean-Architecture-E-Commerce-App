import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/product/get_product.dart';

part 'product_event.dart';
part 'product_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase _getProductUseCase;

  ProductBloc(this._getProductUseCase) : super(ProductInitial()) {
    on<GetProducts>(_onLoadCart);
  }

  void _onLoadCart(GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      final result = await _getProductUseCase(NoParams());
      result.fold(
        (failure) => emit(ProductError(message: _mapFailureToMessage(failure))),
        (products) {
          // print(products.length);
          emit(ProductLoaded(products: products));
          // print(state);
        },
      );
    } catch (e) {
      print(e.toString());
      emit(ProductError(message: e.toString()));
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
