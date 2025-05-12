import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.dart';
import '../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/input_form_button.dart';
import '../../../widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;
    if (currentScroll > (maxScroll * scrollPercentage)) {
      if (context.read<ProductBloc>().state is ProductLoaded) {
        context.read<ProductBloc>().add(const GetMoreProducts());
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: colorScheme.background,
            child: Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).padding.top + 10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                    if (state is UserLogged) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.userProfile);
                              },
                              child: Text(
                                "${state.user.firstName} ${state.user.lastName}",
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onBackground,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.userProfile);
                              },
                              child: state.user.image != null
                                  ? CachedNetworkImage(
                                      imageUrl: state.user.image!,
                                      imageBuilder: (context, image) =>
                                          CircleAvatar(
                                        radius: 18.sp,
                                        backgroundImage: image,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 18.sp,
                                      backgroundImage: AssetImage(kUserAvatar),
                                      backgroundColor: Colors.transparent,
                                    ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                "Welcome,",
                                style: textTheme.headlineMedium?.copyWith(
                                  color: colorScheme.onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "E-Shop mobile store",
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onBackground.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRouter.signIn);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0,
                                backgroundImage: AssetImage(kUserAvatar),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 1.h,
                    left: 6.w,
                    right: 6.w,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<FilterCubit, FilterProductParams>(
                          builder: (context, state) {
                            return TextField(
                              autofocus: false,
                              controller:
                                  context.read<FilterCubit>().searchController,
                              onChanged: (val) => setState(() {}),
                              onSubmitted: (val) => context
                                  .read<ProductBloc>()
                                  .add(GetProducts(
                                      FilterProductParams(keyword: val))),
                              style: TextStyle(color: colorScheme.onBackground),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 16.sp,
                                    bottom: 16.sp,
                                    top: 18.sp,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: colorScheme.onBackground.withOpacity(0.7),
                                  ),
                                  suffixIcon: context
                                          .read<FilterCubit>()
                                          .searchController
                                          .text
                                          .isNotEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: IconButton(
                                              onPressed: () {
                                                context
                                                    .read<FilterCubit>()
                                                    .searchController
                                                    .clear();
                                                context
                                                    .read<FilterCubit>()
                                                    .update(keyword: '');
                                              },
                                              icon: Icon(
                                                Icons.clear,
                                                color: colorScheme.onBackground.withOpacity(0.7),
                                              )),
                                        )
                                      : null,
                                  border: const OutlineInputBorder(),
                                  hintText: "Search Product",
                                  hintStyle: TextStyle(
                                    color: colorScheme.onBackground.withOpacity(0.5),
                                  ),
                                  fillColor: colorScheme.surface,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorScheme.primary, width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(16.sp)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.sp),
                                    borderSide: BorderSide(
                                      color: colorScheme.outline.withOpacity(0.5),
                                      width: 2.0,
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 55,
                        child: BlocBuilder<FilterCubit, FilterProductParams>(
                          builder: (context, state) {
                            return Badge(
                              alignment: AlignmentDirectional.topEnd,
                              label: Text(
                                context
                                    .read<FilterCubit>()
                                    .getFiltersCount()
                                    .toString(),
                                style: TextStyle(color: colorScheme.onPrimary),
                              ),
                              isLabelVisible: context
                                      .read<FilterCubit>()
                                      .getFiltersCount() !=
                                  0,
                              backgroundColor: colorScheme.primary,
                              child: InputFormButton(
                                color: colorScheme.onBackground,
                                onClick: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.filter);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h)
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductLoaded && state.products.isEmpty) {
                    return AlertCard(
                      image: kEmpty,
                      message: "Products not found!",
                      textColor: colorScheme.onBackground,
                    );
                  }
                  if (state is ProductError && state.products.isEmpty) {
                    if (state.failure is NetworkFailure) {
                      return AlertCard(
                        image: kNoConnection,
                        message: "Network failure\nTry again!",
                        textColor: colorScheme.onBackground,
                        onClick: () {
                          context.read<ProductBloc>().add(GetProducts(
                              FilterProductParams(
                                  keyword: context
                                      .read<FilterCubit>()
                                      .searchController
                                      .text)));
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (state.failure is ServerFailure)
                            Image.asset(
                              'assets/status_image/internal-server-error.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          if (state.failure is CacheFailure)
                            Image.asset(
                              'assets/status_image/no-connection.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          Text(
                            "Products not found!",
                            style: TextStyle(color: colorScheme.onBackground.withOpacity(0.7)),
                          ),
                          IconButton(
                              color: colorScheme.primary,
                              onPressed: () {
                                context.read<ProductBloc>().add(GetProducts(
                                    FilterProductParams(
                                        keyword: context
                                            .read<FilterCubit>()
                                            .searchController
                                            .text)));
                              },
                              icon: const Icon(Icons.refresh)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ProductBloc>()
                          .add(const GetProducts(FilterProductParams()));
                    },
                    child: GridView.builder(
                      itemCount: state.products.length +
                          ((state is ProductLoading) ? 10 : 0),
                      controller: scrollController,
                      padding: EdgeInsets.only(
                          top: 18,
                          left: 20,
                          right: 20,
                          bottom: (80 + MediaQuery.of(context).padding.bottom)),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 20,
                      ),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (state.products.length > index) {
                          return ProductCard(
                            product: state.products[index],
                          );
                        } else {
                          return Shimmer.fromColors(
                            baseColor: colorScheme.surface,
                            highlightColor: colorScheme.surface.withOpacity(0.5),
                            child: const ProductCard(),
                          );
                        }
                      },
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}
