import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'loading_widget.dart';
import 'shimmers.dart';

class PaginationListWidget extends StatelessWidget {
  const PaginationListWidget({
    super.key,
    required this.list,
    required this.listItemWidget,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    this.padding,
    this.enablePullDown = true,
    this.isLoading = false,
  });
  final List list;
  final Function(int) listItemWidget;
  final RefreshController controller;
  final Function()? onRefresh;
  final Function()? onLoading;
  final EdgeInsets? padding;
  final bool isLoading;
  final bool enablePullDown;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ListShimmerwidget()
        : list.isEmpty
            ? SmartRefresher(
                header: const MaterialClassicHeader(),
                controller: controller,
                enablePullDown: enablePullDown,
                onRefresh: onRefresh,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'No record to show',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                // ),
              )
            : SmartRefresher(
                controller: controller,
                onRefresh: onRefresh,
                onLoading: onLoading,
                enablePullUp: true,
                enablePullDown: enablePullDown,
                header: const MaterialClassicHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text(
                        "No more records to load",
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    } else if (mode == LoadStatus.loading) {
                      body = const LoadingWidget();
                    } else if (mode == LoadStatus.failed) {
                      body = Text(
                        "Load Failed! Click retry!",
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text(
                        "release to load more",
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    } else {
                      body = Text(
                        "No more Data",
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    }
                    return SizedBox(
                      height: 0.0,
                      child: Center(child: body),
                    );
                  },
                ),
                child: ListView.builder(
                  padding: padding,
                  itemCount: list.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(
                        milliseconds: 375,
                      ),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: listItemWidget(index),
                        ),
                      ),
                    );
                  },
                ),
              );
  }
}
