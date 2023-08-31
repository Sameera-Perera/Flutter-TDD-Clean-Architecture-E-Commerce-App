import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/presentation/widgets/favorite_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/router/app_router.dart';
import '../../domain/entities/product/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final Function? onFavoriteToggle;
  final Function? onClick;
  const ProductCard({
    Key? key,
    this.product,
    this.onFavoriteToggle,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: product == null
          ? Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.white,
              child: buildBody(context),
            )
          : buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (product != null) {
          Navigator.of(context)
              .pushNamed(AppRouter.productDetails, arguments: product);
        }
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Card(
                color: Colors.white,
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: product == null
                    ? Material(
                        child: GridTile(
                          footer: Container(),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      )
                    : Hero(
                        tag: product!.id,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: CachedNetworkImage(
                            imageUrl: product!.images.first,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                      ),
              )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: SizedBox(
                    height: 18,
                    child: product == null
                        ? Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                        : Text(
                            product!.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 18,
                      child: product == null
                          ? Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                          : Text(
                              r'$' + product!.priceTags.first.price.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            right: 0,
            child: FavoriteIconButton(
              // cloth: cloth,
            ),
          ),
        ],
      ),
    );
  }
}
