import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function? onFavoriteToggle;
  final Function? onClick;
  const ProductCard({
    Key? key,
    required this.product,
    this.onFavoriteToggle,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(AppRouter.clothDetails, arguments: cloth);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Card(
                      color: Colors.black,
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Hero(
                        tag: product.id,
                        child: Material(
                          child: GridTile(
                            footer: Container(),
                            // child: const Placeholder(),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: Row(
                    children: [
                      Text(
                        r'$' + product.price.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // color: cloth.discountPrice == null
                          //     ? Colors.black87
                          //     : Colors.grey,
                          // decoration: cloth.discountPrice == null
                          //     ? null
                          //     : TextDecoration.lineThrough,
                        ),
                      ),
                      // product.discountPrice == null
                      //     ? const SizedBox()
                      //     : Text(
                      //   ' \$${cloth.discountPrice}',
                      //   style: const TextStyle(
                      //       fontSize: 16, fontWeight: FontWeight.w600),
                      // )
                    ],
                  ),
                )
              ],
            ),
            // Positioned(
            //   top: 10,
            //   right: 0,
            //   child: FavoriteClothButton(
            //     cloth: cloth,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
