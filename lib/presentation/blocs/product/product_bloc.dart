import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshop/domain/entities/product/pagination_meta_data.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/product/product.dart';
import '../../../domain/usecases/product/get_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase _getProductUseCase;

  ProductBloc(this._getProductUseCase)
      : super(ProductInitial(
            products: const [],
            metaData: PaginationMetaData(
              pageSize: 20,
              page: 0,
              total: 0,
            ))) {
    on<GetProducts>(_onLoadProducts);
  }

  void _onLoadProducts(GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading(products: state.products, metaData: state.metaData));
      final result = await _getProductUseCase(NoParams());
      result.fold(
        (failure) => emit(ProductError(
            products: state.products,
            metaData: state.metaData,
            message: _mapFailureToMessage(failure))),
        (productResponse) => emit(ProductLoaded(
          metaData: state.metaData,
          products: productResponse.products,
        )),
      );
    } catch (e) {
      print(e);
      emit(ProductError(
        products: state.products,
        metaData: state.metaData,
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
