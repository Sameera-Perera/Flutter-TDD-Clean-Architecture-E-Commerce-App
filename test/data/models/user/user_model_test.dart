import 'package:eshop/domain/entities/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';

void main() {
  test(
    'UserModel should be a subclass of User entity',
        () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );
}