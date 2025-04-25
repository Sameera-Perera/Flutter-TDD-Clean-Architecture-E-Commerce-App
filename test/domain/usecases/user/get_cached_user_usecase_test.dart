import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/user_repository.dart';
import 'package:eshop/domain/usecases/user/get_local_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  late GetLocalUserUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetLocalUserUseCase(mockRepository);
  });

  test(
    'Should get User from the repository when User Repository return data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.getLocalUser())
          .thenAnswer((_) async => const Right(tUserModel));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, const Right(tUserModel));
      verify(() => mockRepository.getLocalUser());
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.getLocalUser())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getLocalUser());
    verifyNoMoreInteractions(mockRepository);
  });
}
