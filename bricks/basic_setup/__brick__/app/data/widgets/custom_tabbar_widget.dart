import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    Key? key,
    required this.controller,
    required this.tabs,
    this.selectedColor,
    this.isForProfile = false,
  }) : super(key: key);
  final TabController controller;
  final List<Widget> tabs;
  final Color? selectedColor;
  final bool isForProfile;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        isScrollable: isForProfile ? false : true,
        controller: controller,
        // indicatorWeight: 2.w,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.only(right: isForProfile ? 0 : 14.5.w),
        indicatorColor: selectedColor ?? Theme.of(context).primaryColor,
        // indicatorPadding: EdgeInsets.symmetric(horizontal: 2.h),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
        labelStyle:
            Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),

        labelColor: selectedColor ?? Theme.of(context).primaryColor,
        unselectedLabelColor: const Color(0xFF4E4E4E),
        tabs: tabs,
      ),
    );
  }
}
