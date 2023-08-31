import 'package:flutter/material.dart';

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
            child: Row(
              children: [
                const Hero(
                  tag: "C001",
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                    AssetImage('assets/dev/user.jpg'),
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
            ),
          ),
          const SizedBox(height: 30),
          OtherItemCard(
            onClick: () {
              // Navigator.of(context).pushNamed(AppRouter.profile);
            },
            title: "Profile",
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
          OtherItemCard(
            onClick: () {
              // context.read<AuthBloc>().add(SignOutAuth());
            },
            title: "Sign Out",
          ),
        ],
      ),
    );
  }
}
