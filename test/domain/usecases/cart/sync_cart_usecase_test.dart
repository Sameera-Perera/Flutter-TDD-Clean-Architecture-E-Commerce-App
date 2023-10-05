import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/cart_repository.dart';
import 'package:eshop/domain/usecases/cart/sync_cart_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late SyncCartUseCase usecase;
  late MockCartRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockCartRepository();
    usecase = SyncCartUseCase(mockProductRepository);
  });

  test(
    'Should get cart item from the repository when Cart Repository add data successfully',
        () async {
      /// Arrange
      when(() => mockProductRepository.syncCart())
          .thenAnswer((_) async => Right([tCartItemModel]));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (cart) => expect(cart, [tCartItemModel]),
      );
      verify(() => mockProductRepository.syncCart());
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.syncCart())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockProductRepository.syncCart());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
