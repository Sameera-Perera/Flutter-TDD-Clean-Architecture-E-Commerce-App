import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class SearchProductUseCase implements UseCase<List<Product>, SearchProductParams> {
  final ProductRepository repository;
  SearchProductUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(SearchProductParams params) async {
    return await repository.searchProducts(params);
  }
}

class SearchProductParams extends Equatable {
  final String title;

  const SearchProductParams({required this.title});

  @override
  List<Object> get props => [title];
}
