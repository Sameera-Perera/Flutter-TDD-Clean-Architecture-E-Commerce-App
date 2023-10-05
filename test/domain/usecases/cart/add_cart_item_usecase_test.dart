import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/domain/repositories/cart_repository.dart';
import 'package:eshop/domain/usecases/cart/add_cart_item_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late AddCartUseCase usecase;
  late MockCartRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockCartRepository();
    usecase = AddCartUseCase(mockProductRepository);
  });

  test(
    'Should get cart item from the repository when Cart Repository add data successfully',
    () async {
      /// Arrange
      when(() => mockProductRepository.addToCart(tCartItemModel))
          .thenAnswer((_) async => Right(tCartItemModel));

      /// Act
      final result = await usecase(tCartItemModel);

      /// Assert
      expect(result, Right(tCartItemModel));
      verify(() => mockProductRepository.addToCart(tCartItemModel));
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.addToCart(tCartItemModel))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tCartItemModel);

    /// Assert
    expect(result, Left(failure));
    verify(
        () => mockProductRepository.addToCart(tCartItemModel));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
