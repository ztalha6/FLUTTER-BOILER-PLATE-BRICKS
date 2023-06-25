import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomExpandedAppBar extends StatelessWidget {
  const CustomExpandedAppBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 70,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFc4c6d4),
                    Color(0xFFcaccda),
                    Color(0xFFcdcfdd),
                    Color(0xFFe3e5f6),
                    Color(0xFFe4e7f8),
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: Stack(
        children: [
          Container(
            height: Get.height / 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFc4c6d4),
                  Color(0xFFcaccda),
                  Color(0xFFcdcfdd),
                  Color(0xFFe3e5f6),
                  Color(0xFFe4e7f8),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: child,
          ),
        ],
      ),
    );
  }
}
