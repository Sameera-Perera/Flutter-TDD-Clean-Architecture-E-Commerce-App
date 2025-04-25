import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/cart_repository.dart';
import 'package:eshop/domain/usecases/cart/delete_cart_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late DeleteCartUseCase usecase;
  late MockCartRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockCartRepository();
    usecase = DeleteCartUseCase(mockProductRepository);
  });

  test(
    'Should get clea item from the repository when Cart Repository clear data successfully',
    () async {
      /// Arrange
      when(() => mockProductRepository.deleteCart())
          .thenAnswer((_) async => Right(NoParams()));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(NoParams()));
      verify(() => mockProductRepository.deleteCart());
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.deleteCart())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockProductRepository.deleteCart());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
