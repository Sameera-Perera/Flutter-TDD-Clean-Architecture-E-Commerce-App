import 'package:eshop/domain/entities/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'UserModel should be a subclass of User entity',
    () async {
      /// Assert
      expect(tUserModel, isA<User>());
    },
  );
}
