import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {Key? key, required this.tabController, required this.tabs, this.onTap})
      : super(key: key);

  final TabController tabController;
  final List<Tab> tabs;
  final Function(int value)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.06,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TabBar(
        onTap: onTap,
        unselectedLabelColor: Colors.grey.shade100,
        labelColor: kSecondaryColor,
        indicator: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        controller: tabController,
        tabs: tabs,
      ),
    );
  }
}
