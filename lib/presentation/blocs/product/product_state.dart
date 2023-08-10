part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final List<Product> products;
  final PaginationMetaData metaData;
  const ProductState({required this.products, required this.metaData});
}

class ProductInitial extends ProductState {
  const ProductInitial({required super.products, required super.metaData});
  @override
  List<Object> get props => [];
}

class ProductEmpty extends ProductState {
  const ProductEmpty({required super.products, required super.metaData});
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading({required super.products, required super.metaData});
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  const ProductLoaded({required super.products, required super.metaData});
  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required super.products, required super.metaData,
    required this.message});
  @override
  List<Object> get props => [];
}
