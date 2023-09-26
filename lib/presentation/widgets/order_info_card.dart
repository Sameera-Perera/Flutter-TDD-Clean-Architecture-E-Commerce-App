import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/order/order_details.dart';
import 'outline_label_card.dart';

class OrderInfoCard extends StatelessWidget {
  final OrderDetails? orderDetails;
  const OrderInfoCard({Key? key, this.orderDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderDetails != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: OutlineLabelCard(
          title: '',
          child: Container(
            padding: const EdgeInsets.only(
              top: 12
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order ID : ${orderDetails!.id}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Order Items : ${orderDetails!.orderItems.length}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Order Price : ${orderDetails!.orderItems.fold(0.0, (previousValue, element) => (previousValue + (element.price * element.quantity)))}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Discount : ${orderDetails!.discount}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Column(
                  children: orderDetails!.orderItems
                      .map((product) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 75,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(8.0),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: product
                                        .product.images.first,
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
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
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.edit_location),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 14,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 18,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
