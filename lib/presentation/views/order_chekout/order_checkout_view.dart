import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/input_form_button.dart';
import '../../widgets/outline_label_card.dart';

class OrderCheckoutView extends StatelessWidget {
  const OrderCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Order Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 12,
            ),
            OutlineLabelCard(
              title: 'Delivery Details',
              child: Container(
                height: 90,
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Latoya M. Jones"),
                      Text("3033 Sumner Street"),
                      Text("Gardena, CA 90247"),
                    ]),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<CartBloc, CartState>(builder: (context, state) => OutlineLabelCard(
              title: 'Selected Products',
              child: Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 8),
                child: Column(
                  children: state.cart
                      .map((product) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: product.product.images.first,
                              )

                              // Image.asset(
                              //   product.product.images.first,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                product.product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                  '\$${product.priceTag.price.toStringAsFixed(2)}')
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                      .toList(),
                ),
              ),
            ),),
            const SizedBox(
              height: 16,
            ),
            // OutlineLabelCard(
            //   title: 'Order Summery',
            //   child: Container(
            //     height: 120,
            //     padding: const EdgeInsets.symmetric(vertical: 8),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text("Total Number of Items"),
            //             Text("x${cloths.length}")
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text("Total Price"),
            //             Text(
            //                 "\$${cloths.fold(0.0, (previousValue, element) => element.price)}")
            //           ],
            //         ),
            //         const Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [Text("Delivery Charge"), Text("\$4.99")],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text("Total"),
            //             Text(
            //                 "\$${(cloths.fold(0.0, (previousValue, element) => element.price) + 4.99)}")
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Builder(builder: (context) {
            return InputFormButton(
              color: Colors.black87,
              onClick: () {
                // var orderPlaceBloc = context.read<OrderPlaceCubit>();
                // orderPlaceBloc.placeOrder();
              },
              titleText: 'Confirm',
            );
          }),
        ),
      ),
    );
  }
}
