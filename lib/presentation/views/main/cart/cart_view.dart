import 'package:flutter/material.dart';

import '../../../../domain/entities/product/product.dart';
import '../../../widgets/Product/product_card.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).padding.top + 10),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    itemCount: 10,
                    padding: const EdgeInsets.only(top: 14),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 6,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: Product(
                          id: '1',
                          name: "name",
                          description: '',
                          priceTags: [],
                          images: [],
                          categories: [],
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
