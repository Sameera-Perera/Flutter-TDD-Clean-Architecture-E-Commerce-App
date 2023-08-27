import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/category/category.dart';

class CategoryCard extends StatelessWidget {
  final Category? category;
  const CategoryCard({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(AppRouter.clothDetails, arguments: cloth);
      },
      child: category != null
          ? Card(
              color: Colors.black,
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Hero(
                  tag: '', //product.id,
                  child: Material(
                    child: GridTile(
                      footer: Container(),
                      child: CachedNetworkImage(
                        imageUrl: category!.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      // child: Image.asset(
                      //   product.image,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),
              ),
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.white70,
              child: Card(
                color: Colors.black,
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: Material(
                    child: GridTile(footer: Container(), child: Container()),
                  ),
                ),
              ),
            ),
    );
  }
}
