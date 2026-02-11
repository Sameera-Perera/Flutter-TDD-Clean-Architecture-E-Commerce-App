import 'package:eshop/features/home/presentation/bloc/navbar_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NavbarCubit cubit;
  setUp(() {
    cubit = NavbarCubit();
  });

  test('initialState should be Empty', () {
    // Assert
    expect(cubit.state, equals(0));
  });

  test(
    'should update state value after call update method',
    () async {
      // Act
      cubit.update(1);
      // Assert
      expect(cubit.state, equals(1));
    },
  );
}
