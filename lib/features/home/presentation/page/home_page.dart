import 'package:etmaen/features/home/presentation/widgets/commitment_alert_box.dart';
import 'package:etmaen/features/home/presentation/widgets/home_hedar.dart';
import 'package:etmaen/features/home/presentation/widgets/inform_cards.dart';
import 'package:etmaen/features/home/presentation/widgets/weekly_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeSliverAppBar(),
        const SliverToBoxAdapter(
          child: InformCards(),
        ),
        const SliverToBoxAdapter(
          child: WeeklyStats(),
        ),
        const SliverToBoxAdapter(
          child: CommitmentAlertBox(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 300.h,
          ),
        ),
      ],
    );
  }
}
