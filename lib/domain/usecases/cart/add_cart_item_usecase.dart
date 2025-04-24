import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/cart/cart_item.dart';
import '../../repositories/cart_repository.dart';

class AddCartUseCase implements UseCase<CartItem, CartItem> {
  final CartRepository repository;
  AddCartUseCase(this.repository);

  @override
  Future<Either<Failure, CartItem>> call(CartItem params) async {
    return await repository.addCartItem(params);
  }
}
