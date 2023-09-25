import 'package:eshop/domain/entities/order/order_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constent_objects.dart';

void main() {
  test(
    'OrderItemModel should be a subclass of OrderItem entity',
        () async {
      // assert
      expect(tOrderItemModel, isA<OrderItem>());
    },
  );
}
