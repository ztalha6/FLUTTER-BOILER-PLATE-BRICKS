import 'package:flutter/material.dart';

class CustonmAppBar extends StatelessWidget {
  const CustonmAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(0, 0),
      child: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0.5,
        centerTitle: true,
      ),
    );
  }
}
