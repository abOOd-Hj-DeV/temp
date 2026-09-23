import 'package:etmaen/core/constants/app_colors.dart';
import 'package:etmaen/core/constants/app_pages_name.dart';
import 'package:etmaen/core/constants/app_strings.dart';
import 'package:etmaen/features/home/presentation/widgets/commitment_alert_box.dart';
import 'package:etmaen/features/home/presentation/widgets/home_hedar.dart';
import 'package:etmaen/features/home/presentation/widgets/inform_cards.dart';
import 'package:etmaen/features/home/presentation/widgets/weekly_stats.dart';
import 'package:etmaen/features/patient/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:etmaen/features/patient/presentation/widgets/state_placeholder.dart';
import 'package:etmaen/shared/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardBloc>()..add(const DashboardRequested()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          switch (state) {
            case DashboardProfileRequired():
              return StatePlaceholder(
                icon: Icons.person_outline,
                message: AppStrings.profileRequired,
                actionLabel: AppStrings.completeProfileTitle,
                onRetry: () =>
                    Modular.to.pushNamed(AppRouteName.completeProfile),
              );
            case DashboardFailure():
              return StatePlaceholder(
                icon: Icons.error_outline,
                message: state.message,
                onRetry: () => context
                    .read<DashboardBloc>()
                    .add(const DashboardRequested()),
              );
            case DashboardLoaded():
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async => context
                    .read<DashboardBloc>()
                    .add(const DashboardRequested()),
                child: CustomScrollView(
                  slivers: [
                    HomeSliverAppBar(dashboard: state.dashboard),
                    const SliverToBoxAdapter(child: InformCards()),
                    SliverToBoxAdapter(
                        child: WeeklyStats(progress: state.progress)),
                    const SliverToBoxAdapter(child: CommitmentAlertBox()),
                    SliverToBoxAdapter(child: SizedBox(height: 120.h)),
                  ],
                ),
              );
            default:
              return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary));
          }
        },
      ),
    );
  }
}
