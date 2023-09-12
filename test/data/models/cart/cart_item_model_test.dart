import 'package:eshop/domain/entities/cart/cart_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';

void main() {
  test(
    'CartItemModel should be a subclass of CartItem entity',
        () async {
      // assert
      expect(tCartItemModel, isA<CartItem>());
    },
  );
}
