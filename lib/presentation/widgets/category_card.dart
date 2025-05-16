import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/presentation/blocs/filter/filter_cubit.dart';
import 'package:eshop/presentation/blocs/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/category/category.dart';
import '../blocs/home/navbar_cubit.dart';

class CategoryCard extends StatelessWidget {
  final Category? category;
  const CategoryCard({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        if(category!=null){
          context.read<NavbarCubit>().controller.animateToPage(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
          context.read<NavbarCubit>().update(0);
          context.read<FilterCubit>().update(
            category: category
          );
          context.read<ProductBloc>().add(GetProducts(context.read<FilterCubit>().state));
        }
      },
      child: category != null
          ? Stack(
              children: [
                Card(
                  color: colorScheme.surface,
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: double.maxFinite,
                    child: Hero(
                      tag: category!.id,
                      child: CachedNetworkImage(
                        imageUrl: category!.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: colorScheme.surface,
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: colorScheme.error),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 25,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      category!.name,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Shimmer.fromColors(
              baseColor: colorScheme.surface,
              highlightColor: colorScheme.surface.withOpacity(0.5),
              child: Card(
                color: colorScheme.surface,
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                ),
              ),
            ),
    );
  }
}
