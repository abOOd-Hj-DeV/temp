import 'package:etmaen/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class BookingPagesList extends StatelessWidget {
  const BookingPagesList({
    super.key,
    required PageController pageViewController,
    required this.pageList,
  }) : _pageViewController = pageViewController;

  final PageController _pageViewController;
  final List<Widget> pageList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.lgPadding),
      child: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: pageList,
      ),
    );
  }
}
