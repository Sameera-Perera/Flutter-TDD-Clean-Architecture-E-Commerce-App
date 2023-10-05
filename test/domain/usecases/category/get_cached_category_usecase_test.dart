import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/category_repository.dart';
import 'package:eshop/domain/usecases/category/get_cached_category_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockCartRepository extends Mock implements CategoryRepository {}

void main() {
  late GetCachedCategoryUseCase usecase;
  late MockCartRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockCartRepository();
    usecase = GetCachedCategoryUseCase(mockProductRepository);
  });

  test(
    'Should get category from the repository when Category Repository add data successfully',
        () async {
      /// Arrange
      when(() => mockProductRepository.getCachedCategories())
          .thenAnswer((_) async => const Right([tCategoryModel]));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      result.fold(
            (failure) => fail('Test Fail!'),
            (cart) => expect(cart, [tCategoryModel]),
      );
      verify(() => mockProductRepository.getCachedCategories());
      verifyNoMoreInteractions(mockProductRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockProductRepository.getCachedCategories())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockProductRepository.getCachedCategories());
    verifyNoMoreInteractions(mockProductRepository);
  });
}
