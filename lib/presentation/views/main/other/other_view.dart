import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/router/app_router.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/other_item_card.dart';

class OtherView extends StatelessWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLogged) {
                  return Row(
                    children: [
                      const Hero(
                        tag: "C001",
                        child: CircleAvatar(
                          radius: 36.0,
                          backgroundImage: AssetImage('assets/dev/user.jpg'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wanda R. Fincher",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Text("WandaRFincher@teleworm.us")
                        ],
                      ),
                    ],
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.signIn);
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 36.0,
                          backgroundImage: AssetImage(kUserAvatar),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login in your account",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Text("")
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return OtherItemCard(
                onClick: () {
                  if (state is UserLogged) {
                  } else {
                    Navigator.of(context).pushNamed(AppRouter.signIn);
                  }
                },
                title: "Profile",
              );
            },
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            onClick: () {
              // Navigator.of(context).pushNamed(AppRouter.settings);
            },
            title: "Settings",
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            onClick: () {
              // Navigator.of(context).pushNamed(AppRouter.notifications);
            },
            title: "Notifications",
          ),
          const SizedBox(height: 6),
          OtherItemCard(
            onClick: () {
              // Navigator.of(context).pushNamed(AppRouter.about);
            },
            title: "About",
          ),
          const SizedBox(height: 6),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLogged) {
                return OtherItemCard(
                  onClick: () {
                    // context.read<AuthBloc>().add(SignOutAuth());
                  },
                  title: "Sign Out",
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
