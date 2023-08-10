import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/product/product_response.dart';
import '../../repositories/product_repository.dart';

class GetProductUseCase implements UseCase<ProductResponse, NoParams> {
  final ProductRepository repository;
  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductResponse>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
