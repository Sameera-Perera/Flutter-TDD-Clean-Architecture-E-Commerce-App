import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/repositories/user_repository.dart';
import 'package:eshop/domain/usecases/user/sign_out_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockRepository extends Mock implements UserRepository {}

void main() {
  late SignOutUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignOutUseCase(mockRepository);
  });

  test(
    'Should call sign out method successfully',
        () async {
      /// Arrange
      when(() => mockRepository.signOut())
          .thenAnswer((_) async => Right(NoParams()));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(NoParams()));
      verify(() => mockRepository.signOut());
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.signOut())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.signOut());
    verifyNoMoreInteractions(mockRepository);
  });
}
