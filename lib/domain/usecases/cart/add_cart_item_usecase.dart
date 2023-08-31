import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/cart/cart_item.dart';
import '../../repositories/cart_repository.dart';

class AddCartUseCase implements UseCase<void, CartItem> {
  final CartRepository repository;
  AddCartUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(CartItem params) async {
    return await repository.addToCart(params);
  }
}
