import 'package:eshop/domain/entities/order/order_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'OrderItemModel should be a subclass of OrderItem entity',
        () async {
      /// Assert
      expect(tOrderItemModel, isA<OrderItem>());
    },
  );
}
