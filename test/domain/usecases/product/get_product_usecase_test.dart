import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/domain/repositories/product_repository.dart';
import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductUseCase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProductUseCase(mockProductRepository);
  });

  test(
    'Should get products from the repository when Product Repository return data successfully',
    () async {
      /// Arrange
      when(() => mockProductRepository
              .getProducts(const FilterProductParams()))
          .thenAnswer((_) async => Right(tProductResponseModel));

      /// Act
      final result = await usecase(const FilterProductParams());

      /// Assert
      expect(result, Right(tProductResponseModel));
      verify(() =>
          mockProductRepository.getProducts(const FilterProductParams()));
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.getProducts(
        const FilterProductParams())).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(const FilterProductParams());

    /// Assert
    expect(result, Left(failure));
    verify(() =>
        mockProductRepository.getProducts(const FilterProductParams()));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
